import 'dart:developer';

import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/commons/dialog_widget.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/enums/snackbar_status.dart';
import 'package:emdr_mindmend/src/core/services/stripe/stripe_methods.dart';
import 'package:emdr_mindmend/src/features/auth/domain/models/user.dart';
import 'package:emdr_mindmend/src/features/home/data/repositories/home_repository_impl.dart';
import 'package:emdr_mindmend/src/features/home/domain/models/subscription.dart';
import 'package:emdr_mindmend/src/features/home/domain/repositories/home_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class HomeViewModel with ChangeNotifier {
  final HomeRepository _homeRepository = HomeRepositoryImpl();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  bool _isBtnEnable = false;

  bool get isBtnEnable => _isBtnEnable;

  bool _isFreeTrailBtnEnable = false;

  bool get isFreeTrailBtnEnable => _isFreeTrailBtnEnable;

  List<GetSubscriptionModel> subscriptionList = [];

  GetSubscriptionModel? selectedSubscription;

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

  Future<void> setSubscription(
      {required Function({
        required SnackBarType snackType,
        required String message,
      }) showSnackBarMsg}) async {
    try {
      setLoading(true);
      if (selectedSubscription?.id != "1") {
        debugPrint(selectedSubscription?.amount.toString());
        await PaymentService()
            .makePayment(amount: ((selectedSubscription?.amount ?? 0.0)));
      }

      final body = {"subscription_id": selectedSubscription?.id};
      final data = await _homeRepository.setSubscription(body: body);

      userData?.subscription = Subscription.fromJson(data['subscription']);
      userData?.isTrialValid = data['isTrialValid'];

      notifyListeners();
      CustomNavigation().pop();

      showSnackBarMsg(
          message: selectedSubscription?.id != "1"
              ? "Subscribed successfully"
              : "Free trail started",
          snackType: SnackBarType.success);
    } catch (e) {
      log(e.toString());
      showSnackBarMsg(message: e.toString(), snackType: SnackBarType.error);
    } finally {
      setLoading(false);
    }
  }

  void selectSubscription(GetSubscriptionModel selectedSubscription) {
    if (selectedSubscription != this.selectedSubscription) {
      this.selectedSubscription = selectedSubscription;
    } else {
      this.selectedSubscription = null;
    }
    setEnableBtn();
  }

  void setEnableBtn() {
    if (selectedSubscription != null) {
      if (selectedSubscription?.id == "1") {
        _isFreeTrailBtnEnable = true;
        _isBtnEnable = false;
      } else {
        _isBtnEnable = true;
        _isFreeTrailBtnEnable = false;
      }
    } else {
      _isBtnEnable = false;
      _isFreeTrailBtnEnable = false;
    }

    notifyListeners();
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
  Future<void> showTutorialCoachFirstTime(BuildContext context) async {
    final isInfoShowed = await _homeRepository.getTutorialShowedOnce();
    if (!isInfoShowed) {
      initializeCoachMarks(context);

      /// once tutorial coach showed make bool true in shared preference
    }
  }

  void initializeCoachMarks(BuildContext context) {
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

    tutorialCoachMark.show(context: context);
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
