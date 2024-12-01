import 'dart:developer';

import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/commons/custom_text_controller.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/enums/login_type.dart';
import 'package:emdr_mindmend/src/core/enums/snackbar_status.dart';
import 'package:emdr_mindmend/src/core/services/local/preferences.dart';
import 'package:emdr_mindmend/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:emdr_mindmend/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/home_screen.dart';
import 'package:emdr_mindmend/src/features/splash/domain/models/credential_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginViewModel with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepositoryImpl();

  CustomTextController emailCon = CustomTextController(
      controller: TextEditingController(), focusNode: FocusNode());
  CustomTextController passwordCon = CustomTextController(
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
        passwordCon.controller.text.isNotEmpty) {
      if (emailCon.error == null && passwordCon.error == null) {
        _isBtnEnable = true;
      } else {
        _isBtnEnable = false;
      }
    } else {
      _isBtnEnable = false;
    }

    notifyListeners();
  }

  clearForm() {
    emailCon = CustomTextController(
        controller: TextEditingController(), focusNode: FocusNode());
    passwordCon = CustomTextController(
        controller: TextEditingController(), focusNode: FocusNode());
    notifyListeners();
  }

  Future<void> login(
      {required Function({
        required SnackBarType snackType,
        required String message,
      }) showSnackBarMsg,
      required WidgetRef ref}) async {
    try {
      setLoading(true);

      final body = {
        "email": emailCon.controller.text,
        "password": passwordCon.controller.text,
      };
      final userData = await _authRepository.login(body: body);
      ref.read(userModelProvider.notifier).setUser(userData);

      final credentialsModel = CredentialsModel(
          loginType: LoginType.normal,
          email: emailCon.controller.text,
          password: passwordCon.controller.text);
      await SPreferences().saveCredentials(credentialsModel);
      CustomNavigation().pushReplacement(const HomeScreen());
    } catch (e) {
      showSnackBarMsg(message: e.toString(), snackType: SnackBarType.error);
    } finally {
      setLoading(false);
    }
  }

  Future<void> googleLogin(
      {required Function({
        required SnackBarType snackType,
        required String message,
      }) showSnackBarMsg,
      required WidgetRef ref}) async {
    try {
      setLoading(true);
      final credentials = await _authRepository.googleLogin();

      if (credentials != null) {
        final body = {
          "name": credentials.displayName,
          "email": credentials.email
        };

        final userData = await _authRepository.googleSocialLogin(body: body);
        ref.read(userModelProvider.notifier).setUser(userData);
        final credentialsModel = CredentialsModel(
            loginType: LoginType.google,
            name: credentials.displayName,
            email: credentials.email);
        await SPreferences().saveCredentials(credentialsModel);
        CustomNavigation().pushReplacement(const HomeScreen());
      }
    } on Exception catch (e) {
      log("googleLogin error = $e");
      showSnackBarMsg(message: e.toString(), snackType: SnackBarType.error);
    } finally {
      setLoading(false);
    }
  }

  Future<void> appleLogin(
      {required Function({
        required SnackBarType snackType,
        required String message,
      }) showSnackBarMsg,required WidgetRef ref}) async {
    try {
      setLoading(true);
      final credentials = await _authRepository.appleLogin();

      final body = {
        "name": credentials.givenName ?? "",
        "id": credentials.userIdentifier,
        "email": credentials.email ?? ""
      };

      final userData = await _authRepository.appleSocialLogin(body: body);
      ref.read(userModelProvider.notifier).setUser(userData);
      final credentialsModel = CredentialsModel(
          loginType: LoginType.apple, id: credentials.userIdentifier);
      await SPreferences().saveCredentials(credentialsModel);
      CustomNavigation().pushReplacement(const HomeScreen());
    } on Exception catch (e) {
      log("appleLogin error = $e");
      showSnackBarMsg(message: e.toString(), snackType: SnackBarType.error);
    } finally {
      setLoading(false);
    }
  }

  Future<void> autoLogin(
      {required Function({
      required SnackBarType snackType,
      required String message,
      }) showSnackBarMsg,
        required CredentialsModel credentials,
        required WidgetRef ref}) async {
    try {
      setLoading(true);
      final userData =
      await _authRepository.autoLogin(credentials: credentials);

      ref.read(userModelProvider.notifier).setUser(userData);

      // After successful login, navigate to HomeScreen
      CustomNavigation().pushReplacement(const HomeScreen());
    } catch (e) {
      log("autoLogin error = $e");
      showSnackBarMsg(message: e.toString(), snackType: SnackBarType.error);
    } finally {
      setLoading(false);
    }
  }
}
