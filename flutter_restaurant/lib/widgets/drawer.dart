import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/home');
            },
          ),
          ListTile(
            title: Text('Menu'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/menu');
            },
          ),
          ListTile(
            title: Text('Reservation'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/reservation');
            },
          ),
          ListTile(
            title: Text('About'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/about');
            },
          ),
          ListTile(
            title: Text('Contact'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/contact');
            },
          ),
          ListTile(
            title: Text('Feedback'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/feedback');
            },
          ),
          ListTile(
            title: Text('Users'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/users');
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              // Handle logout action
            },
          ),
        ],
      ),
    );
  }
}
