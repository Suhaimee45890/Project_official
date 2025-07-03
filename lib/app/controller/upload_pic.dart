import 'dart:io' show File;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class UploadImg {
  File? _image;
  final ImagePicker imagePicker = ImagePicker();

  Future<void> PickImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
  }
}
