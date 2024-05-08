import 'package:flutter/material.dart';
import 'package:flutter_restaurant/widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  final double headerImageHeightFactor; // Parameter to adjust header image height

  // Constructor to initialize the header image height factor
  HomeScreen({this.headerImageHeightFactor = 0.7});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children: [
                // Header image container
                Container(
                  height: screenHeight * headerImageHeightFactor,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("lib/img/header-img.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Menu items displayed in two columns
                GridView.count(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20),
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                  children: [
                    _buildMenuListTile('English Breakfast', '£12'),
                    _buildMenuListTile('Spicy Beef', '£15'),
                    _buildMenuListTile('Spaghetti Bolognese', '£11'),
                    _buildMenuListTile('Coffee', '£2'),
                    _buildMenuListTile('Juice', '£1'),
                    _buildMenuListTile('Spirits', '£5'),
                  ],
                ),
                // Footer with image and about us paragraph
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'Lorem ipsum dolor sit amet consectetur adipisicing elit...',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/about');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black),
                          ),
                        ),
                        child: Text('More About Us'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Text and buttons positioned over the images
            Positioned(
              top: screenHeight * headerImageHeightFactor * 0.35,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  Text(
                    'Welcome to Mobile Restaurant',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 39, 39, 39),
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 8.0,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/menu');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.black),
                      ),
                    ),
                    child: Text('View Menu'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuListTile(String title, String price) {
    return ListTile(
      title: Text(title, style: TextStyle(color: const Color.fromARGB(255, 2, 2, 2))),
      trailing: Text(price, style: TextStyle(color: const Color.fromARGB(255, 2, 2, 2))),
    );
  }
}
