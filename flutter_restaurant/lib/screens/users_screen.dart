import 'package:flutter/material.dart';
import 'package:flutter_restaurant/services/auth_service.dart'; // Ensure this is correctly pointing to your UserProvider
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserManagementScreen extends StatefulWidget {
  @override
  _UserManagementScreenState createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  late List<dynamic> _users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    var response = await http.get(Uri.parse('http://10.0.2.2:5000/api/users'));
    if (response.statusCode == 200) {
      setState(() {
        _users = jsonDecode(response.body);
      });
    } else {
      // Handle error
      print("Failed to fetch users");
    }
  }

  Future<void> _addUser(String username, String email, String password, bool isAdmin) async {
    var response = await http.post(
      Uri.parse('http://10.0.2.2:5000/api/user/add'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
        'isAdmin': isAdmin ? 1 : 0,
      }),
    );
    if (response.statusCode == 201) {
      _fetchUsers(); // Refresh the list after adding a user
    } else {
      // Handle error
      print("Failed to add user");
    }
  }

  Future<void> _deleteUser(int id) async {
    var response = await http.delete(Uri.parse('http://10.0.2.2:5000/api/user/delete/$id'));
    if (response.statusCode == 200) {
      _fetchUsers(); // Refresh the list after deleting a user
    } else {
      // Handle error
      print("Failed to delete user");
    }
  }

  void _showAddUserDialog() {
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    bool isAdmin = false;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New User'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: usernameController,
                  cursorColor: Colors.black, // Set cursor color to black
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  style: TextStyle(color: Colors.black),
                ),
                TextField(
                  controller: emailController,
                  cursorColor: Colors.black, // Set cursor color to black
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  style: TextStyle(color: Colors.black),
                ),
                TextField(
                  controller: passwordController,
                  cursorColor: Colors.black, // Set cursor color to black
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  style: TextStyle(color: Colors.black),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isAdmin,
                      onChanged: (bool? value) {
                        setState(() {
                          isAdmin = value ?? false;
                        });
                      },
                    ),
                    Text('Is Admin', style: TextStyle(color: Colors.black)),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.black)), // Set text color to black
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Save', style: TextStyle(color: Colors.black)), // Set text color to black
              onPressed: () {
                _addUser(usernameController.text, emailController.text, passwordController.text, isAdmin);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var isAdmin = Provider.of<UserProvider>(context).user.isAdmin;
    if (!isAdmin) {
      return Scaffold(
        appBar: AppBar(
          title: Text("User Management"),
        ),
        body: Center(child: Text("You are not authorized to view this page")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('User Management'),
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_users[index]['username']),
            subtitle: Text(_users[index]['email']),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteUser(_users[index]['id']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddUserDialog,
        child: Icon(Icons.add),
        backgroundColor: Colors.black, // Set background color to black
        foregroundColor: Colors.white, // Set icon color to white
      ),
    );
  }
}
