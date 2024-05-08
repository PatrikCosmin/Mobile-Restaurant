import 'package:flutter/material.dart';
import 'package:flutter_restaurant/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReservationScreen extends StatefulWidget {
  final String reservationId;
  final String originalDate;
  final String originalTime;
  final String originalGuests;

  ReservationScreen({
    required this.reservationId,
    required this.originalDate,
    required this.originalTime,
    required this.originalGuests,
  });

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  late TextEditingController _dateController;
  late TextEditingController _timeController;
  late TextEditingController _guestsController;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(text: widget.originalDate);
    _timeController = TextEditingController(text: widget.originalTime);
    _guestsController = TextEditingController(text: widget.originalGuests);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Reservation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date'),
            TextFormField(
              controller: _dateController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                hintText: 'Enter date (YYYY-MM-DD)',
              ),
            ),
            SizedBox(height: 20.0),
            Text('Time'),
            TextFormField(
              controller: _timeController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                hintText: 'Enter time (HH:MM)',
              ),
            ),
            SizedBox(height: 20.0),
            Text('Number of Guests'),
            TextFormField(
              controller: _guestsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter number of guests',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _updateReservation(),
              child: Text('Update Reservation'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateReservation() async {
    String date = _dateController.text;
    String time = _timeController.text;
    int guests = int.tryParse(_guestsController.text) ?? 0;

    if (date.isNotEmpty && time.isNotEmpty && guests > 0) {
      var response = await http.put(
        Uri.parse('http://10.0.2.2:5000/api/reservations/${widget.reservationId}'),
        body: jsonEncode({
          'date': date,
          'time': time,
          'guests': guests,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Reservation updated successfully'),
          ),
        );
        Navigator.pop(context); // Return to previous screen after updating
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update reservation'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _guestsController.dispose();
    super.dispose();
  }
}
