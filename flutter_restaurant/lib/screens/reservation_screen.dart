import 'package:flutter/material.dart';
import 'package:flutter_restaurant/widgets/drawer.dart';

class ReservationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservations'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('Manage your Reservations'),
      ),
    );
  }
}
