import 'package:flutter/material.dart';
import 'package:flutter_restaurant/screens/home_screen.dart';
import 'package:flutter_restaurant/screens/menu_screen.dart';
import 'package:flutter_restaurant/screens/reservation_screen.dart';
import 'package:flutter_restaurant/screens/about_screen.dart';
import 'package:flutter_restaurant/screens/contact_screen.dart';
import 'package:flutter_restaurant/screens/feedback_screen.dart';
import 'package:flutter_restaurant/screens/users_screen.dart';
import 'package:flutter_restaurant/screens/login_screen.dart';
import 'package:flutter_restaurant/screens/register_screen.dart';
import 'package:flutter_restaurant/screens/edit_menu_item_screen.dart';
import 'package:flutter_restaurant/screens/edit_reservation_screen.dart';
import 'package:flutter_restaurant/screens/edit_user_screen.dart';
import 'package:flutter_restaurant/screens/edit_feedback_screen.dart';
// import 'package:flutter_restaurant/widgets/drawer.dart'; // Ensure you are importing your custom drawer if needed

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Restaurant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/home',
      routes: {
        '/': (context) => HomeScreen(),  // Consider using HomeScreen directly if BaseScreen is not adding value
        '/home': (context) => HomeScreen(),
        '/menu': (context) => MenuScreen(),
        '/reservation': (context) => ReservationScreen(),
        '/about': (context) => AboutScreen(),
        '/contact': (context) => ContactScreen(),
        '/feedback': (context) => FeedbackScreen(),
        '/users': (context) => UsersScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/edit_menu_item': (context) => EditMenuItemScreen(),
        '/edit_reservation': (context) => EditReservationScreen(),
        '/edit_user': (context) => EditUserScreen(),
        '/edit_feedback': (context) => EditFeedbackScreen(),
        // Add other routes as needed
      },
    );
  }
}
