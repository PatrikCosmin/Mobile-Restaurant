import 'package:flutter/material.dart';
import 'package:flutter_restaurant/widgets/drawer.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('Explore our Menu'),
      ),
    );
  }
}
