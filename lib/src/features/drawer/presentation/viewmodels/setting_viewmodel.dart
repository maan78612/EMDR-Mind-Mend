import 'package:audioplayers/audioplayers.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/enums/color_ball.dart';
import 'package:emdr_mindmend/src/features/drawer/data/repositories/drawer_repository_impl.dart';
import 'package:emdr_mindmend/src/features/drawer/domain/repositories/drawer_repository.dart';
import 'package:flutter/material.dart';

class SettingViewModel with ChangeNotifier {
  final DrawerRepository _drawerRepository = DrawerRepositoryImpl();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  /// Set page index
  int settingPageIndex = 0;
  List<String> settingOptions = ["Auditory", "Visual"];

  void setPageIndex(int index) {
    settingPageIndex = index;

    notifyListeners();
  }

  /// Set Tone index
  late AudioPlayer audioPlayer;

  List<String> toneList = [
    "sound/tone1.wav",
    "sound/tone2.wav",
    "sound/tone3.wav",
    "sound/tone4.wav",
  ];
  int selectedToneIndex = 0;

  bool isPlaying = false;

  void playSound(int audioSourceIndex) async {
    if (selectedToneIndex != audioSourceIndex) {
      isPlaying = true;
      selectedToneIndex = audioSourceIndex;
      notifyListeners();

      double balance = -1.0; // Start from the left speaker
      double balanceIncrement = 0.1; // Amount to increment balance

      while (isPlaying) {
        // Loop for left to right transition
        while (balance <= 1.0 && isPlaying) {
          await audioPlayer.setBalance(balance);
          await audioPlayer.play(AssetSource(toneList[selectedToneIndex]));
          await Future.delayed(const Duration(milliseconds: 50)); // Adjust as needed for smoother transition
          balance += balanceIncrement;
        }

        // Loop for right to left transition
        while (balance >= -1.0 && isPlaying) {
          await audioPlayer.setBalance(balance);
          await audioPlayer.play(AssetSource(toneList[selectedToneIndex]));
          await Future.delayed(const Duration(milliseconds: 50)); // Adjust as needed for smoother transition
          balance -= balanceIncrement;
        }

        // Ensure balance ends exactly at -1.0 for next iteration
        if (balance < -1.0) {
          balance = -1.0;
        }
      }
    }
  }

  void stopSound() {
    isPlaying = false; // Set the flag to false to stop playing
    audioPlayer.stop();

    notifyListeners(); // Stop the audio player
  }

  /// Set Speed index
  double speed = 1;

  void setSpeed(double index) {
    speed = index;
    notifyListeners();
  }

  /// Set Color index

  BallColor ballColor = BallColor.green;

  Color getColor(BallColor color) {
    switch (color) {
      case BallColor.grey:
        return const Color(0xffD1D5E8);
      case BallColor.green:
        return AppColors.primaryColor;
      case BallColor.red:
        return AppColors.redColor;
      case BallColor.blue:
        return const Color(0xff2E64F8);
      case BallColor.yellow:
        return const Color(0xffFFDE0A);
      case BallColor.black:
        return AppColors.blackColor;
    }
  }

  void setBallColor(BallColor color) {
    ballColor = color;
    notifyListeners();
  }

  /*------------------------------------------------------*/
  /*-----------------------ANIMATION----------------------*/
  /*------------------------------------------------------*/

  bool isAnimationInitialize = false;

  void initAnimation(bool initAnimation) {
    isAnimationInitialize = initAnimation;
    notifyListeners();
  }
}
