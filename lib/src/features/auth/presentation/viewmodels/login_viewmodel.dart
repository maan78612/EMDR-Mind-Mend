import 'package:emdr_mindmend/src/core/commons/custom_text_controller.dart';
import 'package:emdr_mindmend/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:emdr_mindmend/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

class LoginViewModel with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepositoryImpl();

  CustomTextController uIdCon = CustomTextController(
      controller: TextEditingController(), focusNode: FocusNode());
  CustomTextController passwordCon = CustomTextController(
      controller: TextEditingController(), focusNode: FocusNode());
  CustomTextController tenantCon = CustomTextController(
      controller: TextEditingController(), focusNode: FocusNode());

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  bool _isBtnEnable = false;

  bool get isBtnEnable => _isBtnEnable;

  set setLoading(bool loading) {
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
    if (uIdCon.controller.text.isNotEmpty &&
        passwordCon.controller.text.isNotEmpty) {
      if (uIdCon.error == null && passwordCon.error == null) {
        _isBtnEnable = true;
      } else {
        _isBtnEnable = false;
      }
    } else {
      _isBtnEnable = false;
    }

    notifyListeners();
  }

  Future<void> login() async {}
}
