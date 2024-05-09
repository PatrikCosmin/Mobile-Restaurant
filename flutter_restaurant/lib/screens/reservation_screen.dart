import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter_restaurant/services/auth_service.dart';

class ReservationScreen extends StatefulWidget {
  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController guestsController = TextEditingController();
  List<String> availableTimes = [];
  List<dynamic> reservations = [];
  bool reservationSubmitted = false;
  int? editReservationId;
  String editDate = '';
  TimeOfDay? editTime;
  int editGuests = 1;

  @override
  void initState() {
    super.initState();
    fetchReservations();
  }

  void fetchAvailableTimes(String date) async {
    var response = await http.get(
      Uri.parse('http://10.0.2.2:5000/api/reservations/times?date=$date'),
    );
    if (response.statusCode == 200) {
      setState(() {
        availableTimes = List<String>.from(json.decode(response.body)['times']);
      });
    }
  }

  void fetchReservations() async {
    var response = await http.get(
      Uri.parse('http://10.0.2.2:5000/api/reservations'),
    );
    if (response.statusCode == 200) {
      setState(() {
        reservations = json.decode(response.body);
      });
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: editReservationId == null ? DateTime.now() : DateTime.parse(editDate),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith( // Change the theme to dark
            colorScheme: ColorScheme.dark(
              primary: Colors.white, // Foreground color
              onPrimary: Colors.black, // Background color
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        editDate = picked.toIso8601String().split('T')[0];
        dateController.text = editDate;
        fetchAvailableTimes(editDate);
      });
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: editTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith( // Change the theme to dark
            colorScheme: ColorScheme.dark(
              primary: Colors.white, // Foreground color
              onPrimary: Colors.black, // Background color
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        editTime = picked;
        timeController.text = picked.format(context);
      });
    }
  }

  void createOrUpdateReservation() async {
    if (editReservationId == null) {
      var response = await http.post(
        Uri.parse('http://10.0.2.2:5000/api/reservations'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'date': dateController.text,
          'time': timeController.text,
          'guests': int.parse(guestsController.text),
        }),
      );
      if (response.statusCode == 200) {
        setState(() {
          reservationSubmitted = true;
          Future.delayed(Duration(seconds: 5), () {
            setState(() {
              reservationSubmitted = false;
            });
          });
          fetchReservations();  // Refresh the list after booking
        });
      }
    } else {
      var response = await http.put(
        Uri.parse('http://10.0.2.2:5000/api/reservations/$editReservationId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'date': editDate,
          'time': timeController.text,
          'guests': editGuests,
        }),
      );
      if (response.statusCode == 200) {
        setState(() {
          editReservationId = null;
          fetchReservations();  // Refresh the list after update
          fetchAvailableTimes(editDate);  // Refresh times available
        });
      }
    }
  }

  void startEditReservation(dynamic reservation) {
    setState(() {
      editReservationId = reservation['id'];
      editDate = reservation['date'];
      editTime = TimeOfDay(hour: int.parse(reservation['time'].split(':')[0]), minute: int.parse(reservation['time'].split(':')[1]));
      editGuests = reservation['guests'];
      dateController.text = editDate;
      timeController.text = "${editTime!.format(context)}";
      guestsController.text = editGuests.toString();
      fetchAvailableTimes(editDate);
    });
  }

  void deleteReservation(int id) async {
    var response = await http.delete(
      Uri.parse('http://10.0.2.2:5000/api/reservations/$id'),
    );
    if (response.statusCode == 200) {
      fetchReservations();
    }
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).user;
    if (!user.isLoggedIn) {
      return Scaffold(
        appBar: AppBar(title: Text("Reservation")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("You must be logged in to make a reservation."),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                child: Text("Go to Login"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Manage Reservations")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () => selectDate(context),
              child: AbsorbPointer(
                child: TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                    labelText: "Date",
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => selectTime(context),
              child: AbsorbPointer(
                child: TextField(
                  controller: timeController,
                  decoration: InputDecoration(
                    labelText: "Time",
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
              ),
            ),
            DropdownButtonFormField<int>(
              value: editGuests,
              decoration: InputDecoration(
                labelText: "Number of Guests",
                labelStyle: TextStyle(color: Colors.black),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
              ),
              items: List<int>.generate(100, (i) => i + 1)
                  .map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString(), style: TextStyle(color: Colors.black)),
                );
              }).toList(),
              onChanged: (int? newValue) {
                setState(() {
                  editGuests = newValue ?? 1;
                  guestsController.text = newValue.toString();
                });
              },
            ),
            ElevatedButton(
              onPressed: createOrUpdateReservation,
              child: Text(editReservationId == null ? "Book Table" : "Update Reservation"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
            ),
            if (reservationSubmitted) Text("Reservation Successful!"),
            ...reservations.map<Widget>((reservation) {
              return ListTile(
                title: Text("Date: ${reservation['date']}, Time: ${reservation['time']}, Guests: ${reservation['guests']}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => startEditReservation(reservation),
                      color: Colors.black,
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => deleteReservation(reservation['id']),
                      color: Colors.black,
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
