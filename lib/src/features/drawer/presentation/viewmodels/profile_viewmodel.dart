import 'dart:io';

import 'package:emdr_mindmend/src/core/commons/custom_text_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileViewModel with ChangeNotifier {
  CustomTextController emailCon = CustomTextController(
      controller: TextEditingController(), focusNode: FocusNode());
  CustomTextController nameCon = CustomTextController(
      controller: TextEditingController(), focusNode: FocusNode());

  File? profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> imageOptionClick(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      notifyListeners();
    }
  }
}