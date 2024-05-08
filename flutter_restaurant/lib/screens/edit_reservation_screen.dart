import 'package:flutter/material.dart';
import 'package:flutter_restaurant/widgets/drawer.dart';

class EditReservationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Reservation'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('Modify your reservation'),
      ),
    );
  }
}
