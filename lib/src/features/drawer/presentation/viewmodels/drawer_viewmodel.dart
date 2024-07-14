import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/enums/snackbar_status.dart';
import 'package:emdr_mindmend/src/features/auth/presentation/views/login_screen.dart';
import 'package:emdr_mindmend/src/features/drawer/data/repositories/drawer_repository_impl.dart';
import 'package:emdr_mindmend/src/features/drawer/domain/repositories/drawer_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DrawerViewModel with ChangeNotifier {
  final DrawerRepository _drawerRepository = DrawerRepositoryImpl();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> logout(
      {required Function({
        required SnackBarType snackType,
        required String message,
      }) showSnackBarMsg}) async {
    try {
      CustomNavigation().pop();
      setLoading(true);

      final body = {"refresh_token": userData?.refreshToken};
      await _drawerRepository.logout(body: body);
      await _drawerRepository.googleLogout();

      userData = null;
      CustomNavigation().pushAndRemoveUntil(LoginScreen());
    } catch (e) {
      showSnackBarMsg(
        message: e.toString(),
        snackType: SnackBarType.error,
      );
    } finally {
      setLoading(false);
    }
  }
}
