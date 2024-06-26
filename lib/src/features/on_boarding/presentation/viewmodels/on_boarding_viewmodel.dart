import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/features/auth/presentation/views/login_screen.dart';
import 'package:emdr_mindmend/src/features/on_boarding/data/repositories/on_boarding_repository_impl.dart';
import 'package:emdr_mindmend/src/features/on_boarding/domain/models/on_boarding.dart';
import 'package:emdr_mindmend/src/features/on_boarding/domain/repositories/on_boarding_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OnBoardingViewModel with ChangeNotifier {
  final OnBoardingRepository _onBoardingRepository = OnBoardingRepositoryImpl();
  List<OnBoardingModel> onBoarding = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  int currentIndex = 0;

  void setIndex() {
    if (currentIndex < onBoarding.length-1) {
      currentIndex = currentIndex + 1;
    } else {
      CustomNavigation().pushReplacement(LoginScreen());
    }
    notifyListeners();
  }

  void init() {
    onBoarding = _onBoardingRepository.populateData();
    notifyListeners();
  }
}
