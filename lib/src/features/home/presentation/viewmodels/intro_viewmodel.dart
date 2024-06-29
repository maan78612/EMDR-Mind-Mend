import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/enums/snackbar_status.dart';
import 'package:emdr_mindmend/src/core/utilities/custom_snack_bar.dart';
import 'package:emdr_mindmend/src/features/home/data/repositories/home_repository_impl.dart';
import 'package:emdr_mindmend/src/features/home/domain/repositories/home_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class IntroViewModel with ChangeNotifier {
  final HomeRepository _homeRepository = HomeRepositoryImpl();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  int introIndex = 0;

  void incrementIndex(BuildContext context) {
    if (introIndex < 10) {
      introIndex = introIndex + 1;
    } else {
      CustomNavigation().pop();
      CustomSnackBar.showSnackBar(
          "Information survey completed", SnackBarType.success, context);
    }

    notifyListeners();
  }

  void decrementIndex() {
    if (introIndex == 0) {
      CustomNavigation().pop();
    } else {
      introIndex = introIndex - 1;
      notifyListeners();
    }
  }

  double intro5Slider = 1;
  double intro6Slider = 1;
  double intro9Slider = 5;
  double intro10Slider = 7;

  void changeSlider(int num, double value) {
    if (num == 1) {
      intro5Slider = value;
    } else if (num == 2) {
      intro6Slider = value;
    } else if (num == 3) {
      intro6Slider = value;
    } else if (num == 4) {
      intro6Slider = value;
    }

    notifyListeners();
  }

  List<String> emotionList = [
    "Fear",
    "Sadness",
    "Shame",
    "Numbness",
    "Anxiety",
    "Helplessness",
    "Anger",
    "Guilt",
  ];

  List<String> addedEmotions = [
    "Sadness",
    "Anger",
  ];

  void addEmotion(String emotion) {
    if (addedEmotions.contains(emotion)) {
      addedEmotions.remove(emotion);
    } else {
      addedEmotions.add(emotion);
    }

    notifyListeners();
  }

  /// Intro 8

  String selectedDesensitisation = "Auditory";
  List<String> desensitisationList = ["Auditory", "Visual"];

  void setDesensitisation(String value) {
    selectedDesensitisation = value;

    notifyListeners();
  }
}
