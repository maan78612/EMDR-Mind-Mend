import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/enums/color_ball.dart';
import 'package:flutter/material.dart';

class SettingViewModel with ChangeNotifier {
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
    if (isPlaying) {
      stopSound();
    }
    settingPageIndex = index;

    notifyListeners();
  }

  /// Set Tone index
  AudioPlayer audioPlayer = AudioPlayer();

  List<String> toneList = [
    "sound/tone1.mp3",
    "sound/tone2.mp3",
    "sound/tone3.mp3",
    "sound/tone4.mp3",
  ];
  int selectedToneIndex = 0;

  bool isPlaying = false;
  Timer? timer;

  void selectTone(int audioSourceIndex) {
    if (selectedToneIndex != audioSourceIndex) {
      selectedToneIndex = audioSourceIndex;
      notifyListeners();
    }
    if (isPlaying) {
      stopSound(); // Stop the current sound and timer
      playSound(); // Start playing sound with the updated speed
    } else {
      playSound();
    }
  }

  double auditorySpeed = 2;

  void setAuditorySpeed(double speed) {
    auditorySpeed = speed;
    notifyListeners();
  }

  void playSound() async {
    isPlaying = true;
    notifyListeners();
    // Calculate interval duration based on auditorySpeed
    int interval = ((3000 - 1000) * (3 - auditorySpeed) / 4 + 1000).toInt();

    timer = Timer.periodic(
      Duration(milliseconds: interval),
      (timer) {
        audioPlayer.play(AssetSource(toneList[selectedToneIndex]));
      },
    );
  }

  // Cancel the timer when the sound should stop
  void stopSound() {
    if (isPlaying) {
      isPlaying = false;
      timer?.cancel();
      audioPlayer.stop();
    }
    notifyListeners();
  }

  /// Set Speed index
  double visualSpeed = 1;

  void setVisualSpeed(double index) {
    visualSpeed = index;
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
        return AppColors.lightPrimaryTextColor;
    }
  }

  void setBallColor(BallColor color) {
    ballColor = color;

    notifyListeners();
  }

  List<Color> bgColorList = [AppColors.whiteColor, AppColors.lightPrimaryTextColor];

  Color bgColor = AppColors.whiteColor;

  void setBgColor(Color color) {
    bgColor = color;
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
