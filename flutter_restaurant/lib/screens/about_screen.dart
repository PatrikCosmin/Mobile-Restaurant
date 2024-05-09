import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AboutScreen extends StatelessWidget {
  final List<String> imgList = [
    'lib/img/about-chef1.jpg',
    'lib/img/about-chef2.jpg',
    'lib/img/about-img.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
              items: imgList
                  .map((item) => Container(
                        child: Center(
                          child: Image.asset(item, fit: BoxFit.cover, width: 1000),
                        ),
                      ))
                  .toList(),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Here at [Your Company Name], we are committed to serving our customers with the best possible service. We believe in quality, commitment, and dedication. Here’s a bit more about our journey and where we aim to be.',
                style: TextStyle(
                  fontSize: 16.0,
                  height: 1.5,  // line spacing
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
