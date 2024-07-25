import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/enums/snackbar_status.dart';
import 'package:emdr_mindmend/src/features/home/data/repositories/home_repository_impl.dart';
import 'package:emdr_mindmend/src/features/home/domain/repositories/home_repository.dart';
import 'package:flutter/material.dart';

class IntroViewModel with ChangeNotifier {
  final HomeRepository _homeRepository = HomeRepositoryImpl();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  int introIndex = 0;

  bool incrementIndex(BuildContext context) {
    if (introIndex < 10) {
      introIndex = introIndex + 1;
      notifyListeners();
      return false;
    } else {
      return true;
    }
  }

  void decrementIndex() {
    if (introIndex == 0) {
      CustomNavigation().pop();
    } else {
      introIndex = introIndex - 1;
      notifyListeners();
    }
  }

  double imageValue = 5;
  double generalEmotion = 5;
  double revaluationOne = 1;
  double revaluationTwo = 1;

  void changeSlider(int num, double value) {
    if (num == 1) {
      imageValue = value;
    } else if (num == 2) {
      generalEmotion = value;
    } else if (num == 3) {
      revaluationOne = value;
    } else if (num == 4) {
      revaluationTwo = value;
    }

    notifyListeners();
  }

  List<Map<int, String>> emotionList = [
    {1: "Fear"},
    {2: "Sadness"},
    {3: "Shame"},
    {4: "Numbness"},
    {5: "Anxiety"},
    {6: "Helplessness"},
    {7: "Anger"},
    {8: "Guilty"}, // Assuming this is an empty string with an associated number
  ];
  List<int> addedEmotions = [];

  void addEmotion(int emotion) {
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

  Future<void> getScore(
      {required Function({
        required SnackBarType snackType,
        required String message,
      }) showSnackBarMsg}) async {
    try {
      setLoading(true);

      await _homeRepository.getScore();
    } catch (e) {
      showSnackBarMsg(message: e.toString(), snackType: SnackBarType.error);
    } finally {
      setLoading(false);
    }
  }

  Future<void> setScore(
      {required Function({
        required SnackBarType snackType,
        required String message,
      }) showSnackBarMsg}) async {
    try {
      setLoading(true);

      final body = {
        "image_value": imageValue,
        "general_emotion_value": generalEmotion,
        "revaluation_one": revaluationOne,
        "revaluation_two": revaluationTwo,
        "selected_emotions": addedEmotions,
      };

      await _homeRepository.sendScore(body: body);
      CustomNavigation().pop();
      showSnackBarMsg(
          message: "User therapy info Saved", snackType: SnackBarType.success);
    } catch (e) {
      showSnackBarMsg(message: e.toString(), snackType: SnackBarType.error);
    } finally {
      setLoading(false);
    }
  }
}
