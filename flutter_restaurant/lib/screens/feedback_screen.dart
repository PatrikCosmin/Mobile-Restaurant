import 'package:flutter/material.dart';
import 'package:flutter_restaurant/widgets/drawer.dart';

class FeedbackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('Leave your Feedback'),
      ),
    );
  }
}
