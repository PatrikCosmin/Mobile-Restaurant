import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final String baseURL = 'http://10.0.2.2:5000';
  List<dynamic> menuItems = [];
  List<String> categories = [];
  String newCategory = '';
  bool isAdmin = false;

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
    isAdmin = Provider.of<UserProvider>(context).user.isAdmin;
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        actions: isAdmin
            ? [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => showAddMenuItemDialog(),
                )
              ]
            : null,
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
                    trailing: isAdmin
                        ? IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => deleteMenuItem(item['id']),
                          )
                        : null,
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
                Text('\$${item['price']}', style: TextStyle(fontSize: 18, color: const Color.fromARGB(255, 54, 54, 54))),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black),
                    ),
                  ),
                  child: Text('Close'),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void showAddMenuItemDialog() {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  String? selectedCategory;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: SingleChildScrollView(
          child: StatefulBuilder(
            builder: (BuildContext context, setState) {
              return Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add New Menu Item',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                    ),
                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(labelText: 'Description'),
                    ),
                    TextFormField(
                      controller: priceController,
                      decoration: InputDecoration(labelText: 'Price'),
                      keyboardType: TextInputType.number,
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedCategory,
                      hint: Text('Select Category'),
                      items: categories.map((String category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList()
                        ..add(DropdownMenuItem<String>(
                          value: 'Other',
                          child: Text('New Category'),
                        )),
                      onChanged: (String? value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },
                    ),
                    if (selectedCategory == 'Other')
                      TextFormField(
                        controller: categoryController,
                        decoration: InputDecoration(labelText: 'New Category'),
                      ),
                    TextFormField(
                      controller: imageController,
                      decoration: InputDecoration(labelText: 'Image URL'),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Validate and save the input data
                            String name = nameController.text.trim();
                            String description = descriptionController.text.trim();
                            double price = double.tryParse(priceController.text.trim()) ?? 0.0;
                            String category = selectedCategory == 'Other' ? categoryController.text.trim() : selectedCategory!;
                            String image = imageController.text.trim();

                            // Call a function to add the new menu item
                            addMenuItem(name, description, price, category, image);

                            // Close the dialog
                            Navigator.pop(context);
                          },
                          child: Text('Add'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
  );
}


  void deleteMenuItem(int id) async {
    try {
      var response = await http.delete(
        Uri.parse('$baseURL/api/menu/delete/$id'),
      );

      if (response.statusCode == 200) {
        // Menu item deleted successfully
        fetchMenuItems(); // Refresh the menu items list
      } else {
        // Error deleting menu item
        print('Failed to delete menu item: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error deleting menu item: $e');
    }
  }

  void addMenuItem(String name, String description, double price, String category, String image) async {
    try {
      var response = await http.post(
        Uri.parse('$baseURL/api/menu/add'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'name': name,
          'description': description,
          'price': price,
          'category': category,
          'image': image,
        }),
      );

      if (response.statusCode == 201) {
        // Menu item added successfully
        fetchMenuItems(); // Refresh the menu items list
      } else {
        // Error adding menu item
        print('Failed to add menu item: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error adding menu item: $e');
    }
  }
}
