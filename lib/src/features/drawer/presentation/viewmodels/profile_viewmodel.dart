import 'dart:io';

import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/commons/custom_text_controller.dart';
import 'package:emdr_mindmend/src/core/enums/snackbar_status.dart';
import 'package:emdr_mindmend/src/features/drawer/data/repositories/drawer_repository_impl.dart';
import 'package:emdr_mindmend/src/features/drawer/domain/repositories/drawer_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileViewModel with ChangeNotifier {
  final DrawerRepository _drawerRepository = DrawerRepositoryImpl();

  CustomTextController emailCon = CustomTextController(
      controller: TextEditingController(text: "john@gmail.com"),
      focusNode: FocusNode());
  CustomTextController nameCon = CustomTextController(
      controller: TextEditingController(text: "John"), focusNode: FocusNode());

  File? profileImage;
  final ImagePicker _picker = ImagePicker();

  bool _isBtnEnable = false;

  bool get isBtnEnable => _isBtnEnable;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> imageOptionClick(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  void deleteImage() {
    if (profileImage != null) {
      profileImage = null;
    }
    notifyListeners();
  }

  void onChange(
      {required CustomTextController con,
      String? Function(String?)? validator,
      required String value}) {
    if (validator != null) {
      con.error = validator(value);
    }
    setEnableBtn();
  }

  void setEnableBtn() {
    if (nameCon.controller.text.isNotEmpty) {
      if (nameCon.error == null) {
        _isBtnEnable = true;
      } else {
        _isBtnEnable = false;
      }
    } else {
      _isBtnEnable = false;
    }

    notifyListeners();
  }

  Future<void> editProfile(
      {required Function({
        required SnackBarType snackType,
        required String message,
      }) showSnackBarMsg}) async {
    List<MapEntry<String, File>> files = [];
    try {
      setLoading(true);
      if (profileImage != null) {
        files.add(MapEntry('image', profileImage!));
      }

      final body = {
        "username": nameCon.controller.text,
      };
      // await _drawerRepository.editProfile(body: body, files: files);
      CustomNavigation().pop();
      showSnackBarMsg(
          message: "Profile saved", snackType: SnackBarType.success);
    } catch (e) {
      showSnackBarMsg(message: e.toString(), snackType: SnackBarType.error);
    } finally {
      setLoading(false);
    }
  }
}
