import 'package:flutter/material.dart';
import 'package:flutter_restaurant/widgets/drawer.dart';

class EditFeedbackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Feedback'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('Review and respond to feedback'),
      ),
    );
  }
}
