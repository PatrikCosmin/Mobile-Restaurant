import 'package:flutter/material.dart';
import 'package:flutter_restaurant/widgets/drawer.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('Learn more About Us'),
      ),
    );
  }
}
