import 'package:flutter/material.dart';
import 'package:flutter_restaurant/widgets/drawer.dart';

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('Get in Touch with Us'),
      ),
    );
  }
}
