import 'package:flutter/material.dart';
import 'package:flutter_restaurant/widgets/drawer.dart';

class EditMenuItemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Menu Item'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('Edit menu item details'),
      ),
    );
  }
}
