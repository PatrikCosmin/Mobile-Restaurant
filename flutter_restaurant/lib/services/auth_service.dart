// lib/services/auth_service.dart
import 'package:flutter/material.dart';

class User {
  final bool isLoggedIn;
  final bool isAdmin;
  final String userId;

  User({this.isLoggedIn = false, this.isAdmin = false, this.userId = ''});
}

class UserProvider with ChangeNotifier {
  User _user = User();

  User get user => _user;

  void login(String userId, {bool isAdmin = false}) {
    _user = User(isLoggedIn: true, isAdmin: isAdmin, userId: userId);
    notifyListeners();
  }

  void logout() {
    _user = User(isLoggedIn: false, isAdmin: false, userId: '');
    notifyListeners();
  }
}
