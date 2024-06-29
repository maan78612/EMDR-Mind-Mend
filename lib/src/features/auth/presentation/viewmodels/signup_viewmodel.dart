import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/commons/custom_text_controller.dart';
import 'package:emdr_mindmend/src/core/enums/snackbar_status.dart';
import 'package:emdr_mindmend/src/core/utilities/custom_snack_bar.dart';
import 'package:emdr_mindmend/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:emdr_mindmend/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

class SignViewModel with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepositoryImpl();

  CustomTextController emailCon = CustomTextController(
      controller: TextEditingController(), focusNode: FocusNode());
  CustomTextController passwordCon = CustomTextController(
      controller: TextEditingController(), focusNode: FocusNode());

  CustomTextController confirmPasswordCon = CustomTextController(
      controller: TextEditingController(), focusNode: FocusNode());
  CustomTextController nameCon = CustomTextController(
      controller: TextEditingController(), focusNode: FocusNode());

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  bool _isBtnEnable = false;

  bool get isBtnEnable => _isBtnEnable;

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
    if (emailCon.controller.text.isNotEmpty &&
        passwordCon.controller.text.isNotEmpty &&
        confirmPasswordCon.controller.text.isNotEmpty &&
        nameCon.controller.text.isNotEmpty) {
      if (emailCon.error == null &&
          passwordCon.error == null &&
          confirmPasswordCon.error == null &&
          nameCon.error == null) {
        _isBtnEnable = true;
      } else {
        _isBtnEnable = false;
      }
    } else {
      _isBtnEnable = false;
    }

    notifyListeners();
  }

  void signUpButton(BuildContext context) {
    if (passwordCon.controller.text != confirmPasswordCon.controller.text) {
      CustomSnackBar.showSnackBar(
          "Password and confirm password does not match",
          SnackBarType.error,
          context);
    } else {
      try {
        setLoading(true);

        final body = {
          "email": emailCon.controller.text,
          "password": passwordCon.controller.text,
          "confirmPassword": confirmPasswordCon.controller.text,
          "name": nameCon.controller.text,
        };

        _authRepository.register(body: body);
        CustomNavigation().pop();
        CustomSnackBar.showSnackBar("Account has been created successfully",
            SnackBarType.success, context);
      } catch (e) {
        CustomSnackBar.showSnackBar(e.toString(), SnackBarType.error, context);
      } finally {
        setLoading(false);
      }
    }
  }
}
