import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiUrl = 'http://localhost:5000';

  // Method to fetch available reservation times based on date
  static Future<List<String>> fetchAvailableReservationTimes(String date) async {
    final response = await http.get(Uri.parse('$apiUrl/api/reservations/times?date=$date'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<String> availableTimes = List<String>.from(jsonData['times']);
      return availableTimes;
    } else {
      throw Exception('Failed to load available times');
    }
  }

  // Method to create a reservation
  static Future<void> createReservation(Map<String, dynamic> reservationData) async {
    final response = await http.post(
      Uri.parse('$apiUrl/api/reservations'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(reservationData),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create reservation');
    }
  }

  // Method to fetch all reservations
  static Future<List<dynamic>> fetchAllReservations() async {
    final response = await http.get(Uri.parse('$apiUrl/api/reservations'));

    if (response.statusCode == 200) {
      final List<dynamic> reservations = json.decode(response.body);
      return reservations;
    } else {
      throw Exception('Failed to load reservations');
    }
  }

  // Add more API service methods here
}
