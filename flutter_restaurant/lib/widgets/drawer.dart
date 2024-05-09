import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_restaurant/services/auth_service.dart'; // Ensure this import is correct

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          final isLoggedIn = userProvider.user.isLoggedIn;
          final isAdmin = userProvider.user.isAdmin;
          return ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 20, 20, 20),
                ),
                child: Text(
                  'Mobile Restaurant',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.popAndPushNamed(context, '/home');
                },
              ),
              ListTile(
                leading: Icon(Icons.restaurant_menu),
                title: Text('Menu'),
                onTap: () {
                  Navigator.popAndPushNamed(context, '/menu');
                },
              ),
              ListTile(
                leading: Icon(Icons.event),
                title: Text('Reservation'),
                onTap: () {
                  Navigator.popAndPushNamed(context, '/reservation');
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About'),
                onTap: () {
                  Navigator.popAndPushNamed(context, '/about');
                },
              ),
              ListTile(
                leading: Icon(Icons.contacts),
                title: Text('Contact'),
                onTap: () {
                  Navigator.popAndPushNamed(context, '/contact');
                },
              ),
              if (isLoggedIn && isAdmin) ListTile(
                leading: Icon(Icons.feedback),
                title: Text('Feedback'),
                onTap: () {
                  Navigator.popAndPushNamed(context, '/feedback');
                },
              ),
              if (isLoggedIn && isAdmin) ListTile(
                leading: Icon(Icons.supervised_user_circle),
                title: Text('Users'),
                onTap: () {
                  Navigator.popAndPushNamed(context, '/users');
                },
              ),
              if (!isLoggedIn) ListTile(
                leading: Icon(Icons.login),
                title: Text('Login'),
                onTap: () {
                  Navigator.popAndPushNamed(context, '/login');
                },
              ),
              if (isLoggedIn) ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () => _confirmLogout(context),
              ),
            ],
          );
        },
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout Confirmation'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();  // Dismiss the dialog but do not logout
              },
              child: Text('No', style: TextStyle(color: Colors.black)), // Set text color to black
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();  // Dismiss the dialog
                _logout(context);  // Proceed with logout
              },
              child: Text('Yes', style: TextStyle(color: Colors.black)), // Set text color to black
            ),
          ],
        );
      },
    );
  }

  void _logout(BuildContext context) {
    Provider.of<UserProvider>(context, listen: false).logout();
    Navigator.pop(context); // Close the drawer
    Navigator.pushReplacementNamed(context, '/home'); // Redirect to home screen
  }
}
