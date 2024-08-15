import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'photo_to_ar.dart'; // Import the PhotoToARScreen
import 'furnitures.dart'; // Import the AvailableFurnituresScreen

class MenuDrawer extends StatelessWidget {
  final List<CameraDescription> cameras;

  MenuDrawer({required this.cameras});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'AR Furniture App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo),
            title: Text('Photo to AR'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PhotoToARScreen(cameras: cameras),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Available Furnitures'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AvailableFurnituresScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
