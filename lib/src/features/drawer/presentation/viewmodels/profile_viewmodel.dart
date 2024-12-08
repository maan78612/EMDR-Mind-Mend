import 'dart:io';

import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/commons/custom_text_controller.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/enums/color_enum.dart';
import 'package:emdr_mindmend/src/core/enums/snackbar_status.dart';
import 'package:emdr_mindmend/src/core/manager/color_manager.dart';
import 'package:emdr_mindmend/src/features/auth/domain/models/user.dart';
import 'package:emdr_mindmend/src/features/drawer/data/repositories/drawer_repository_impl.dart';
import 'package:emdr_mindmend/src/features/drawer/domain/repositories/drawer_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ProfileViewModel with ChangeNotifier {
  final DrawerRepository _drawerRepository = DrawerRepositoryImpl();

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



  Future<void> selectDateOfBirthFunction(
      BuildContext context, ColorMode colorMode) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime(2004),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            dialogBackgroundColor: AppColorHelper.cardColor(colorMode),
            colorScheme: const ColorScheme.light(
                primary: AppColors.primaryColor, // Selected date's circle color
                onPrimary: Colors.white, // Text color on selected date
                onSurface: AppColors
                    .lightPrimaryTextColor // Text color for unselected dates
                ),
            // Background color of the date picker
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      dob.controller.text = DateFormat('dd / MM / yyyy').format(date);
      setEnableBtn();
    }
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
        "first_name": nameCon.controller.text,

        if(countryCon.controller.text.isNotEmpty)"date_of_birth": countryCon.controller.text,
        if(dob.controller.text.isNotEmpty)"country": dob.controller.text,
      };
      final response =
      await _drawerRepository.editProfile(body: body, files: files);

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
