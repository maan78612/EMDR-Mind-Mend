import 'dart:developer';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:emdr_mindmend/src/core/commons/dialog_widget.dart';
import 'package:emdr_mindmend/src/core/enums/snackbar_status.dart';
import 'package:emdr_mindmend/src/features/auth/domain/models/user.dart';
import 'package:emdr_mindmend/src/features/home/data/repositories/home_repository_impl.dart';
import 'package:emdr_mindmend/src/features/home/domain/models/subscription.dart';
import 'package:emdr_mindmend/src/features/home/domain/repositories/home_repository.dart';

import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class HomeViewModel with ChangeNotifier {
  final HomeRepository _homeRepository = HomeRepositoryImpl();
  List<GetSubscriptionModel> subscriptionList = [];

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> initMethod(BuildContext context, UserModel userData) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final isTutorialAlreadyShown =
    await _homeRepository.isTutorialAlreadyShown();
    if (!isTutorialAlreadyShown) {
      await showTutorialCoach(context);
    } else {
      /// TODO : temporarily comment subscription part
      /* ----------------------------------------------

      if (!subscriptionStatus(userData)) {
        await getSubscriptionList(
            showSnackBarMsg: ({
          required SnackBarType snackType,
          required String message,
        }) =>
                SnackBarUtils.show(message, snackType));
        CustomNavigation()
            .push(SubscriptionScreen(subscriptionList: subscriptionList));
      }

       --------------------------------------------- */
    }
    await requestTrackingPermission();
  }

  Future<void> getSubscriptionList(
      {required Function({
      required SnackBarType snackType,
      required String message,
      }) showSnackBarMsg}) async {
    try {
      setLoading(true);

      subscriptionList = await _homeRepository.getSubscription();
    } catch (e) {
      showSnackBarMsg(message: e.toString(), snackType: SnackBarType.error);
    } finally {
      setLoading(false);
    }
  }

  bool subscriptionStatus(UserModel userData) {
    final isTrialValid = userData.isTrialValid ?? false;
    final subscription = userData.subscription;
    final isSubscriptionExpired =
        subscription?.expiryDate.isBefore(DateTime.now()) ?? true;

    debugPrint("isTrialValid = $isTrialValid");
    debugPrint("subscription = $subscription");
    debugPrint("isSubscriptionExpired = $isSubscriptionExpired");

    final isValid =
        isTrialValid || (subscription != null && !isSubscriptionExpired);

    debugPrint("subscription ${isValid ? 'VALID' : 'INVALID'}");
    return isValid;
  }

  ///*------------------------------------------------------*///
  ///*--------------------- Set tutorial Coach-------------------*///
  ///*-----------------------------------------------------*///

  List<TargetFocus> targets = [];
  late TutorialCoachMark tutorialCoachMark;

  final GlobalKey profileButtonKey = GlobalKey();
  final GlobalKey startButtonKey = GlobalKey();
  final GlobalKey eyeButtonKey = GlobalKey();

  /// Check if tutorial  coach showed once app install
  Future<void> showTutorialCoach(BuildContext context) async {
    initializeCoachMarks();
    tutorialCoachMark.show(context: context);
  }

  Future<void> requestTrackingPermission() async {
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;

    // If permission has not been requested, request it
    if (status == TrackingStatus.notDetermined) {
      await AppTrackingTransparency.requestTrackingAuthorization();
    }

    // Log or handle the status (e.g., show a message if permission is denied)
    debugPrint("Tracking status: $status");
  }

  void initializeCoachMarks() {
    targets = [
      TargetFocus(
        keyTarget: profileButtonKey,
        contents: [
          TargetContent(
            padding: EdgeInsets.zero,
            align: ContentAlign.bottom,
            child: _showSettingDialog(),
          ),
        ],
      ),
      TargetFocus(
        keyTarget: startButtonKey,
        contents: [
          TargetContent(
            padding: EdgeInsets.zero,
            align: ContentAlign.top,
            child: _startDialog(),
          ),
        ],
      ),
      TargetFocus(
        keyTarget: eyeButtonKey,
        contents: [
          TargetContent(
            padding: EdgeInsets.zero,
            align: ContentAlign.top,
            child: _eyeDialog(),
          ),
        ],
      ),
    ];

    tutorialCoachMark = TutorialCoachMark(
      targets: targets,
      colorShadow: Colors.black,
      paddingFocus: 0,
      hideSkip: true,
      onFinish: () {
        // Handle finish
      },
    );
  }

  Widget _showSettingDialog() {
    return CustomAlertDialog(
      title: "Settings",
      description: "Change the sound, tone, colour and speed here",
      onTap: () {
        tutorialCoachMark.next(); // Show the next dialog
      },
      btnTitle: 'Next',
    );
  }

  Widget _startDialog() {
    return CustomAlertDialog(
      title: "Start",
      description: "Start the protocol here",
      onTap: () {
        tutorialCoachMark.next(); // Show the next dialog
      },
      btnTitle: 'Next',
    );
  }

  Widget _eyeDialog() {
    return CustomAlertDialog(
      title: "Stimulation",
      description: "Jump straight to audio / visual",
      onTap: () {
        tutorialCoachMark.finish();
        _homeRepository.setTutorialShowedOnce();

        /// set tutorial showed = true
      },
      btnTitle: 'Done',
    );
  }
}
