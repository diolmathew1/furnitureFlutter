import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'ar_view.dart'; // Ensure this import is present

class PhotoToARScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  PhotoToARScreen({required this.cameras});

  @override
  _PhotoToARScreenState createState() => _PhotoToARScreenState();
}

class _PhotoToARScreenState extends State<PhotoToARScreen> {
  late CameraController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.cameras[0], ResolutionPreset.high);
    _controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(title: Text('Photo to AR')),
      body: CameraPreview(_controller),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final image = await _controller.takePicture();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ARViewScreen(
                imagePath: image.path, // Only pass the imagePath
              ),
            ),
          );
        },
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
