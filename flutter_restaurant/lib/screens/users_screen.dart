import 'package:flutter/material.dart';
import 'package:flutter_restaurant/widgets/drawer.dart';

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('User Management Panel'),
      ),
    );
  }
}
