import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'photo_to_ar.dart';
import 'furnitures.dart';
import 'menu_drawer.dart';
import 'image_manager.dart';  // Import the ImageManager

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  // Initialize the ImageManager and load images
  await ImageManager().loadImages();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AR Furniture App',
      theme: ThemeData(
        primaryColor: Colors.black,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
        scaffoldBackgroundColor: Colors.grey[900], // Set background color
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white), // Replaces bodyText1
          bodyMedium: TextStyle(color: Colors.white), // Replaces bodyText2
        ),
      ),
      home: MainScreen(),
      debugShowCheckedModeBanner: false,  // Disable the debug banner
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Main Menu',
          style: TextStyle(color: Colors.white), // Set title color to white
        ),
        backgroundColor: Colors.black, // Set the AppBar color to black
        centerTitle: true, // Center the title in the AppBar
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.white), // Set menu button color to white
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: MenuDrawer(cameras: cameras),  // Add the MenuDrawer here
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ImageManager().getOtherImage('background.jpg').image, // Use the ImageManager to get the background
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[850]?.withOpacity(0.8), // Dark grey background with transparency
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800], // Updated to backgroundColor
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      textStyle: TextStyle(fontSize: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PhotoToARScreen(cameras: cameras)),
                      );
                    },
                    child: Text('Photo to AR', style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800], // Updated to backgroundColor
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      textStyle: TextStyle(fontSize: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AvailableFurnituresScreen()),
                      );
                    },
                    child: Text('Available Furnitures', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
