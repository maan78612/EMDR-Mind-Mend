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
  AudioPlayer? audioPlayer;

  List<String> toneList = [
    "sound/tone1.mp3",
    "sound/tone2.mp3",
    "sound/tone3.mp3",
    "sound/tone4.mp3",
  ];
  int selectedToneIndex = 0;

  bool isPlaying = false;

  void selectTone(int audioSourceIndex) {
    if (selectedToneIndex != audioSourceIndex) {
      selectedToneIndex = audioSourceIndex;
      notifyListeners();
    }
    playSound();
  }

  void playSound() async {
    isPlaying = true;
    audioPlayer = AudioPlayer();
    notifyListeners();
    while (isPlaying) {
      await audioPlayer?.play(AssetSource(toneList[selectedToneIndex]));
      await Future.delayed(Duration(milliseconds: 5000 ~/ (auditorySpeed * 5)));
      notifyListeners();
    }
  }

  void stopSound() {
    if (isPlaying) {
      isPlaying = false; // Set the flag to false to stop playing
      audioPlayer?.stop();
    }

    notifyListeners(); // Stop the audio player
  }

  /// Set Speed index
  double visualSpeed = 1;
  double auditorySpeed = 1;

  void setVisualSpeed(double index) {
    visualSpeed = index;
    notifyListeners();
  }

  void setAuditorySpeed(double index) {
    auditorySpeed = index;
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

  List<Color> bgColorList = [AppColors.whiteColor, AppColors.blackColor];

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
