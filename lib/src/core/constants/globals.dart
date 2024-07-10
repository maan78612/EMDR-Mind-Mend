import 'package:emdr_mindmend/src/features/auth/domain/models/user.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/viewmodels/setting_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const int routingDuration = 300;
double inputFieldHeight = 50.sp;
double hMargin = 24.sp;
String? fcmToken;
final settingViewModelProvider =
    ChangeNotifierProvider<SettingViewModel>((ref) {
  return SettingViewModel();
});

UserModel? userData;

bool subscriptionStatus() {
  if ((userData?.isTrialValid == null && userData?.subscription == null) ||
      (userData?.isTrialValid == false &&
          userData?.subscription != null &&
          userData!.subscription!.expiryDate.isBefore(DateTime.now()))) {
    debugPrint("subscription INVALID");
    return false;
  } else {
    debugPrint("subscription VALID");
    return true;
  }
}
