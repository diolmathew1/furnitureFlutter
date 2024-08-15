import 'package:flutter/material.dart';
import 'image_manager.dart';
import 'ar_view.dart';

class AvailableFurnituresScreen extends StatefulWidget {
  @override
  _AvailableFurnituresScreenState createState() => _AvailableFurnituresScreenState();
}

class _AvailableFurnituresScreenState extends State<AvailableFurnituresScreen> {
  @override
  void initState() {
    super.initState();
    ImageManager().loadImages().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final furnitureList = [
      'sofa.png',
      'dining_table.png',
      'armchair.png',
      'coffee_table.png',
      'bookshelf.png',
      // Add more furniture names here
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Available Furnitures'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: furnitureList.length,
        itemBuilder: (context, index) {
          final furnitureImageName = furnitureList[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: ImageManager().getFurnitureImage(furnitureImageName),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          furnitureImageName.split('.').first.capitalize(),
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'A beautiful and stylish furniture item for your home.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ARViewScreen(imagePath: 'assets/images/furnitures/$furnitureImageName'),
                                  ),
                                );
                              },
                              child: Text('View in AR'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[800],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              ),
                              onPressed: () {
                                // Add action for the button
                              },
                              child: Text('More Info'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

extension StringCasingExtension on String {
  String capitalize() {
    return this[0].toUpperCase() + this.substring(1);
  }
}
