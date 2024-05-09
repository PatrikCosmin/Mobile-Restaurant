import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  List<dynamic> feedbacks = [];
  String searchTerm = '';

  @override
  void initState() {
    super.initState();
    fetchFeedbacks();
  }

  void fetchFeedbacks() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:5000/api/feedbacks'));
      if (response.statusCode == 200) {
        setState(() {
          feedbacks = jsonDecode(response.body);
        });
      } else {
        throw Exception('Failed to load feedbacks');
      }
    } catch (error) {
      print('Error fetching feedbacks: $error');
    }
  }

  void deleteFeedback(int id) async {
    try {
      final response = await http.delete(Uri.parse('http://10.0.2.2:5000/api/feedback/delete/$id'));
      if (response.statusCode == 200) {
        fetchFeedbacks(); // Refetch feedbacks after deletion
      } else {
        throw Exception('Failed to delete feedback');
      }
    } catch (error) {
      print('Error deleting feedback: $error');
    }
  }

  void deleteAllFeedbacks() async {
    try {
      final response = await http.delete(Uri.parse('http://10.0.2.2:5000/api/feedback/all'));
      if (response.statusCode == 200) {
        fetchFeedbacks(); // Refetch feedbacks after deletion
      } else {
        throw Exception('Failed to delete all feedbacks');
      }
    } catch (error) {
      print('Error deleting all feedbacks: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    var filteredFeedbacks = feedbacks.where((feedback) {
      var name = feedback['name'].toLowerCase();
      var email = feedback['email'].toLowerCase();
      var content = feedback['feedback'].toLowerCase();
      return name.contains(searchTerm.toLowerCase()) ||
             email.contains(searchTerm.toLowerCase()) ||
             content.contains(searchTerm.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Feedbacks"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search feedbacks by name, email, or feedback content',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchTerm = value;
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: deleteAllFeedbacks,
            child: Text('Delete All'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredFeedbacks.length,
              itemBuilder: (context, index) {
                var feedback = filteredFeedbacks[index];
                return Card(
                  child: ListTile(
                    title: Text(feedback['name']),
                    subtitle: Text('Email: ${feedback['email']}\nFeedback: ${feedback['feedback']}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => deleteFeedback(feedback['id']),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
