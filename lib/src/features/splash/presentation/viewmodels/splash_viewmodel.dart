import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/services/local/preferences.dart';
import 'package:emdr_mindmend/src/features/auth/presentation/views/login_screen.dart';
import 'package:emdr_mindmend/src/features/on_boarding/presentation/views/on_boarding_screen.dart';
import 'package:emdr_mindmend/src/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:emdr_mindmend/src/features/splash/domain/repositories/splash_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SplashViewModel with ChangeNotifier {
  final SplashRepository _splashRepository = SplashRepositoryImpl();

  Future<void> checkAutoLogin() async {
    final credentials = await SPreferences().getCredentials();

    if (credentials != null) {
      CustomNavigation()
          .pushReplacement(LoginScreen(credentialsModel: credentials));
    } else {
      CustomNavigation().pushReplacement(const OnBoardingScreen());
    }
  }
}
