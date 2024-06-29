import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/commons/custom_text_controller.dart';
import 'package:emdr_mindmend/src/core/enums/snackbar_status.dart';
import 'package:emdr_mindmend/src/core/utilities/custom_snack_bar.dart';
import 'package:emdr_mindmend/src/features/drawer/data/repositories/drawer_repository_impl.dart';
import 'package:emdr_mindmend/src/features/drawer/domain/repositories/drawer_repository.dart';
import 'package:flutter/material.dart';

class ContactUsViewModel with ChangeNotifier {
  final DrawerRepository _drawerRepository = DrawerRepositoryImpl();

  final CustomTextController nameController = CustomTextController(
      controller: TextEditingController(), focusNode: FocusNode());
  final CustomTextController emailController = CustomTextController(
      controller: TextEditingController(), focusNode: FocusNode());
  final CustomTextController messageController = CustomTextController(
      controller: TextEditingController(), focusNode: FocusNode());

  bool _isBtnEnable = false;

  bool get isBtnEnable => _isBtnEnable;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
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
    if (nameController.controller.text.isNotEmpty &&
        emailController.controller.text.isNotEmpty &&
        messageController.controller.text.isNotEmpty) {
      if (nameController.error == null &&
          emailController.error == null &&
          messageController.error == null) {
        _isBtnEnable = true;
      } else {
        _isBtnEnable = false;
      }
    } else {
      _isBtnEnable = false;
    }

    notifyListeners();
  }

  void submitContactUs(BuildContext context) {
    try {
      setLoading(true);

      final body = {
        "email": emailController.controller.text,
        "name": nameController.controller.text,
        "message": messageController.controller.text
      };
      _drawerRepository.contactUs(body: body);
      CustomNavigation().pop();
      CustomSnackBar.showSnackBar(
          "Message sent", SnackBarType.success, context);
    } catch (e) {
      CustomSnackBar.showSnackBar(e.toString(), SnackBarType.error, context);
    } finally {
      setLoading(false);
    }
  }
}
