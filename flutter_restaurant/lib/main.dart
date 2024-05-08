import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart'; // Make sure this path is correct based on your project structure

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
        '/home': (context) => HomeScreen(),
        '/menu': (context) => MenuScreen(),
        '/about': (context) => AboutScreen(),
        '/contact': (context) => ContactScreen(),
        '/feedback': (context) => FeedbackScreen(),
        '/users': (context) => UsersScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
      },
      home: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Flutter Restaurant'),
              actions: <Widget>[
                userProvider.user.isLoggedIn
                    ? IconButton(
                        icon: Icon(Icons.exit_to_app),
                        onPressed: () {
                          Provider.of<UserProvider>(context, listen: false).logout();
                          Navigator.of(context).pushReplacementNamed('/login');
                        },
                      )
                    : IconButton(
                        icon: Icon(Icons.login),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/login');
                        },
                      ),
              ],
            ),
            body: child,
          );
        },
        child: HomeScreen(), // This is the default screen that shows when the app loads
      ),
    );
  }
}
