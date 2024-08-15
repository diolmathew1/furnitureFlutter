import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class ImageManager {
  static final ImageManager _instance = ImageManager._internal();

  factory ImageManager() {
    return _instance;
  }

  ImageManager._internal();

  Map<String, Image> _furnitureImageCache = {};
  Map<String, Image> _otherImageCache = {};

  Future<void> loadImages() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    // Load furniture images from any format
    final furnitureImagePaths = manifestMap.keys
        .where((String key) => key.contains('assets/images/furnitures/'))
        .toList();
    for (var path in furnitureImagePaths) {
      _furnitureImageCache[path] = Image.asset(path);
    }

    // Load other images from any format
    final otherImagePaths = manifestMap.keys
        .where((String key) => key.contains('assets/images/other_purpose/'))
        .toList();
    for (var path in otherImagePaths) {
      _otherImageCache[path] = Image.asset(path);
    }
  }

  Image getFurnitureImage(String imageName) {
    final imagePath = _furnitureImageCache.keys.firstWhere(
          (key) => key.endsWith(imageName),
      orElse: () => 'assets/images/placeholder.png',
    );
    return _furnitureImageCache[imagePath] ?? Image.asset('assets/images/placeholder.png');
  }

  Image getOtherImage(String imageName) {
    final imagePath = _otherImageCache.keys.firstWhere(
          (key) => key.endsWith(imageName),
      orElse: () => 'assets/images/placeholder.png',
    );
    return _otherImageCache[imagePath] ?? Image.asset('assets/images/placeholder.png');
  }

// Add more methods here to manage other categories of images as needed.
}
