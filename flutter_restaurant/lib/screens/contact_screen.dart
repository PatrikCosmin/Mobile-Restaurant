import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const baseURL = 'http://10.0.2.2:5000';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();
  bool feedbackSubmitted = false;

  Future<void> handleSubmit() async {
    var formData = {
      'name': nameController.text,
      'email': emailController.text,
      'feedback': feedbackController.text,
    };

    try {
      var response = await http.post(
        Uri.parse('$baseURL/api/feedback'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(formData),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData['message'] == 'Feedback submitted successfully') {
          setState(() {
            feedbackSubmitted = true;
          });
          nameController.clear();
          emailController.clear();
          feedbackController.clear();
        } else {
          print('Error: ${responseData['message']}');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error submitting feedback: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact Details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Please feel free to reach us on below details:'),
              SizedBox(height: 5),
              Text('Email: contact@restaurant.com'),
              Text('Phone: +123 456 7890'),
              Text('Address: 123 Food Street, Flavor Town, USA'),
              SizedBox(height: 20),
              Text(
                'Restaurant Location',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              // Use GoogleMap widget to display the map
              Container(
                width: double.infinity,
                height: 200,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(37.7749, -122.4194), // San Francisco coordinates
                    zoom: 12,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('marker_id'),
                      position: LatLng(37.7749, -122.4194),
                      infoWindow: InfoWindow(title: 'San Francisco'),
                    ),
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Send Us Your Feedback',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              if (feedbackSubmitted)
                Text(
                  'Thank you for your feedback!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green),
                ),
              if (!feedbackSubmitted) ...[
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Your Name'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Your Email'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: feedbackController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  decoration: InputDecoration(labelText: 'Your Feedback'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Send Feedback'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}