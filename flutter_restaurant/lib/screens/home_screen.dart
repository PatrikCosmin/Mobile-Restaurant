import 'package:flutter/material.dart';
import 'package:flutter_restaurant/widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('Welcome to the Home Screen'),
      ),
    );
  }
}
