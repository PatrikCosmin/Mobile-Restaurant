import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final String baseURL = 'http://10.0.2.2:5000'; // Adjust this as necessary
  List<dynamic> menuItems = [];
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    fetchMenuItems();
  }

  fetchMenuItems() async {
    try {
      var response = await http.get(Uri.parse('$baseURL/api/menu'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List;
        setState(() {
          menuItems = data;
          categories = data.map((item) => item['category']?.toString() ?? '').toSet().toList();
        });
      }
    } catch (e) {
      print('Error fetching menu data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: ListView(
        children: categories.map((category) => buildCategory(category)).toList(),
      ),
    );
  }

  Widget buildCategory(String category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(category.toUpperCase(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        Column(
          children: menuItems
              .where((item) => item['category'] == category)
              .map<Widget>((item) => ListTile(
                    leading: item['image'] != null
                        ? Image.network(item['image'], width: 100, height: 100, fit: BoxFit.cover)
                        : SizedBox(width: 100, height: 100), // Placeholder
                    title: Text(item['name']),
                    subtitle: Text('\$${item['price']}'),
                    onTap: () => showProductDetailsDialog(item),
                  ))
              .toList(),
        ),
      ],
    );
  }

  void showProductDetailsDialog(dynamic item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: double.infinity,
            height: 350,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child: Image.network(item['image'], fit: BoxFit.contain),
                ),
                Text(item['name'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text(item['description'], style: TextStyle(fontSize: 18)),
                Text('\$${item['price']}', style: TextStyle(fontSize: 18, color: Colors.green)),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Close'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
