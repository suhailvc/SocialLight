import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickProvider extends ChangeNotifier {
  String? imageUrl = 'no-image';
  String? imagePath;
  void clearImage() {
    imagePath = 'no-image';
    notifyListeners();
  }

  getImage(ImageSource imageSource) async {
    final returnedImage = await ImagePicker().pickImage(source: imageSource);
    if (returnedImage?.path != null) {
      imagePath = returnedImage!.path;
      notifyListeners();
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference uploadImage =
          FirebaseStorage.instance.ref().child('image').child(fileName);

      await uploadImage.putFile(File(returnedImage.path));

      imageUrl = await uploadImage.getDownloadURL();
      notifyListeners();
    }
  }
}
