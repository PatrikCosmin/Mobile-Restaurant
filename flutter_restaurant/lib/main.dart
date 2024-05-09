import 'package:flutter/material.dart';
import 'package:flutter_restaurant/screens/reservation_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_restaurant/screens/home_screen.dart';
import 'package:flutter_restaurant/screens/menu_screen.dart';
import 'package:flutter_restaurant/screens/about_screen.dart';
import 'package:flutter_restaurant/screens/contact_screen.dart';
import 'package:flutter_restaurant/screens/feedback_screen.dart';
import 'package:flutter_restaurant/screens/users_screen.dart';
import 'package:flutter_restaurant/screens/login_screen.dart';
import 'package:flutter_restaurant/screens/register_screen.dart';
import 'package:flutter_restaurant/services/auth_service.dart'; // Make sure this path is correct

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProvider>(
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: 'Flutter Restaurant',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/home',
        routes: {
          '/home': (context) => HomeScreen(),
          '/menu': (context) => MenuScreen(),
          '/about': (context) => AboutScreen(),
          '/contact': (context) => ContactScreen(),
          '/feedback': (context) => FeedbackScreen(),
          '/reservation': (context) => ReservationScreen(),
          '/users': (context) => UserManagementScreen(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegistrationScreen(),
          // Ensure to add the '/reservation' route if it's a part of your app
        },
      ),
    );
  }
}
