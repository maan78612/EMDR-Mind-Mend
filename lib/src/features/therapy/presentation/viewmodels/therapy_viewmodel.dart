import 'package:chewie/chewie.dart';
import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/features/therapy/data/repositories/therapy_repository_impl.dart';
import 'package:emdr_mindmend/src/features/therapy/domain/repositories/therapy_repository.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:emdr_mindmend/src/core/enums/snackbar_status.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class TherapyViewModel with ChangeNotifier {
  final TherapyRepository _therapyRepository = TherapyRepositoryImpl();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    if (_isLoading == loading) return;
    _isLoading = loading;
    notifyListeners();
  }

  // Therapy progress state
  int introIndex = 0;

  /// Get the total number of screens based on the `isShort` flag.
  int getTotalScreens(bool isShort) => isShort ? 4 : 10;

  /// Increment the index, returning `true` if the last screen is reached.
  bool incrementIndex(bool isShort) {
    final totalScreens = getTotalScreens(isShort);
    if (introIndex < totalScreens - 1) {
      introIndex++;
      _stopVideoPlayer();
      notifyListeners();

      return false;
    }
    return true;
  }

  /// Decrement the index, popping the navigation stack if at the start.
  void decrementIndex() {
    if (introIndex > 0) {
      introIndex--;
      _stopVideoPlayer();
      notifyListeners();
    }
  }

  // Slider values
  double imageValue = 5;
  double generalEmotion = 5;
  double revaluationOne = 1;
  double revaluationTwo = 1;

  void changeSlider(int sliderId, double value) {
    switch (sliderId) {
      case 1:
        imageValue = value;
        break;
      case 2:
        generalEmotion = value;
        break;
      case 3:
        revaluationOne = value;
        break;
      case 4:
        revaluationTwo = value;
        break;
      default:
        return;
    }
    notifyListeners();
  }

  // Emotion management
  final List<Map<int, String>> emotionList = const [
    {1: "Fear"},
    {2: "Sadness"},
    {3: "Shame"},
    {4: "Numbness"},
    {5: "Anxiety"},
    {6: "Helplessness"},
    {7: "Anger"},
    {8: "Guilty"},
  ];
  final Set<int> addedEmotions = {};

  void toggleEmotion(int emotionId) {
    if (!addedEmotions.add(emotionId)) {
      addedEmotions.remove(emotionId);
    }
    notifyListeners();
  }

  // Desensitization selection
  String selectedDesensitisation = "Auditory";
  final List<String> desensitisationList = const ["Auditory", "Visual"];

  void setDesensitisation(String value) {
    selectedDesensitisation = value;
    notifyListeners();
  }

  Future<void> setScore({
    required Function({
      required SnackBarType snackType,
      required String message,
    }) showSnackBarMsg,
  }) async {
    try {
      setLoading(true);
      final body = {
        "image_value": imageValue,
        "general_emotion_value": generalEmotion,
        "revaluation_one": revaluationOne,
        "revaluation_two": revaluationTwo,
        "selected_emotions": addedEmotions.toList(),
      };
      await _therapyRepository.sendScore(body: body);
      _resetFields();
      showSnackBarMsg(
        message: "Therapy info saved successfully",
        snackType: SnackBarType.success,
      );
    } catch (e) {
      showSnackBarMsg(
        message: "Error saving therapy info: ${e.toString()}",
        snackType: SnackBarType.error,
      );
    } finally {
      setLoading(false);
    }
  }

  void _resetFields() {
    addedEmotions.clear();
    imageValue = 5;
    generalEmotion = 5;
    revaluationOne = 1;
    revaluationTwo = 1;
    introIndex = 0;
    notifyListeners();
  }

  /*------------------- video player ----------------------------*/

  ChewieController? _chewieController;

  ChewieController? get chewieController => _chewieController;

  Future<void> initializeVideoPlayer() async {
    final videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'));

    await videoPlayerController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: false,
      showControls: true,
      allowFullScreen: true,
      cupertinoProgressColors: ChewieProgressColors(
          playedColor: AppColors.primaryColor,
          handleColor: AppColors.darkScaffoldColor,
          backgroundColor: Colors.black26,
          bufferedColor: Colors.white),
      materialProgressColors: ChewieProgressColors(
          playedColor: AppColors.primaryColor,
          handleColor: AppColors.darkScaffoldColor,
          backgroundColor: Colors.black26,
          bufferedColor: Colors.white),
    );

    // Initialize the Chewie controller
    await _chewieController?.videoPlayerController.initialize();

    _chewieController?.videoPlayerController.pause();
    notifyListeners();
  }

  // Stop and reset the video
  void stopAndResetVideo() {
    _chewieController?.videoPlayerController.pause();
    _chewieController?.videoPlayerController.seekTo(Duration.zero);
    notifyListeners();
  }

  // Reset Chewie controller and listeners
  void resetVideoController() {
    _chewieController?.videoPlayerController.pause();
    _chewieController?.dispose();
    _chewieController = null;
  }

  // Stop the video player based on conditions
  void _stopVideoPlayer() {
    if (introIndex == 1) {
      return;
    } else if (introIndex != 1) {
      stopAndResetVideo();
    }
  }
}
