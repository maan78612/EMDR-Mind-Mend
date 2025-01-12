import 'dart:io';

import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/commons/custom_text_controller.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/enums/snackbar_status.dart';
import 'package:emdr_mindmend/src/features/auth/domain/models/user.dart';
import 'package:emdr_mindmend/src/features/profile/data/repositories/profile_repository_impl.dart';

import 'package:emdr_mindmend/src/features/profile/domain/repositories/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:image_picker/image_picker.dart';

class EditProfileViewModel with ChangeNotifier {
  final ProfileRepository _profileRepository = ProfileRepositoryImpl();

  CustomTextController emailCon = CustomTextController(
      controller: TextEditingController(), focusNode: FocusNode());
  CustomTextController dob = CustomTextController(
      controller: TextEditingController(), focusNode: FocusNode());
  CustomTextController countryCon = CustomTextController(
      controller: TextEditingController(), focusNode: FocusNode());
  CustomTextController nameCon = CustomTextController(
      controller: TextEditingController(), focusNode: FocusNode());

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

  void initMethod(UserModel userData) {
    emailCon.controller.text = userData.email;
    nameCon.controller.text = userData.name;
    dob.controller.text = userData.dob ?? "";
    countryCon.controller.text = userData.country ?? "";
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
      }) showSnackBarMsg,
      required WidgetRef ref}) async {
    List<MapEntry<String, File>> files = [];
    try {
      setLoading(true);
      if (profileImage != null) {
        files.add(MapEntry('image', profileImage!));
      }

      final body = {
        "name": nameCon.controller.text,
        if (dob.controller.text.isNotEmpty)
          "date_of_birth": dob.controller.text,
        if (countryCon.controller.text.isNotEmpty)
          "country": countryCon.controller.text,
      };
      final response =
          await _profileRepository.editProfile(body: body, files: files);

      ref.read(userModelProvider.notifier).updateProfile(
            newName: response.data.name,
            imageUrl: response.data.image,
            country: response.data.country,
            dob: response.data.dob,
          );

      notifyListeners();

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
