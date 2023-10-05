import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickProvider extends ChangeNotifier {
  String? imageUrl;
  String? imagePath;
  String? returnedImage;
  void clearImage() {
    returnedImage = null;
    imageUrl = null;
    imagePath = null;
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

      await uploadImage.putFile(File(imagePath!));

      imageUrl = await uploadImage.getDownloadURL();
      notifyListeners();
    }
  }
}
