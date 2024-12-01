import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/enums/snackbar_status.dart';
import 'package:emdr_mindmend/src/core/services/local/preferences.dart';
import 'package:emdr_mindmend/src/features/auth/presentation/views/login_screen.dart';
import 'package:emdr_mindmend/src/features/drawer/data/repositories/drawer_repository_impl.dart';
import 'package:emdr_mindmend/src/features/drawer/domain/repositories/drawer_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      }) showSnackBarMsg,
        required WidgetRef ref}) async {
    try {
      CustomNavigation().pop();
      setLoading(true);

      final body = {"refresh_token": ref.read(userModelProvider).refreshToken};
      await _drawerRepository.logout(body: body);
      await SPreferences().clearCredentials();
      await _drawerRepository.googleLogout();

      ref.read(userModelProvider.notifier).clearUser();
      CustomNavigation().pushAndRemoveUntil(const LoginScreen());
    } catch (e) {
      showSnackBarMsg(
        message: e.toString(),
        snackType: SnackBarType.error,
      );
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteUser(
      {required Function({
      required SnackBarType snackType,
      required String message,
      }) showSnackBarMsg,
        required WidgetRef ref}) async {
    try {
      CustomNavigation().pop();
      setLoading(true);

      await _drawerRepository.deleteUser(
          userId: ref.read(userModelProvider).userId.toString());

      await _drawerRepository.googleLogout();

      CustomNavigation().pushAndRemoveUntil(const LoginScreen());
      showSnackBarMsg(
          message:
          "User [${ref.read(userModelProvider).name} has been deleted successfully!",
          snackType: SnackBarType.success);
      await SPreferences().clearCredentials();
      ref.read(userModelProvider.notifier).clearUser();
    } catch (e) {
      showSnackBarMsg(message: e.toString(), snackType: SnackBarType.error);
    } finally {
      setLoading(false);
    }
  }
}
