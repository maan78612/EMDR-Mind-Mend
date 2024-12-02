import 'dart:developer';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:emdr_mindmend/src/core/enums/snackbar_status.dart';
import 'package:emdr_mindmend/src/features/auth/domain/models/user.dart';
import 'package:emdr_mindmend/src/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:emdr_mindmend/src/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:emdr_mindmend/src/features/home/domain/models/subscription.dart';

import 'package:flutter/material.dart';

class DashBoardViewModel with ChangeNotifier {
  final DashBoardRepository _dashBoardRepository = DashBoardRepositoryImpl();
  List<GetSubscriptionModel> subscriptionList = [];

  int selectedIndex = 0;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void selectIndex(int index) {
    if (selectedIndex != index) {
      selectedIndex = index;
      notifyListeners();
    }
  }

  Future<void> initMethod(BuildContext context, int index) async {
    selectedIndex = index;
    notifyListeners();

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

    await requestTrackingPermission();
  }

  Future<void> getSubscriptionList(
      {required Function({
        required SnackBarType snackType,
        required String message,
      }) showSnackBarMsg}) async {
    try {
      setLoading(true);

      subscriptionList = await _dashBoardRepository.getSubscription();
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

  Future<void> requestTrackingPermission() async {
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;

    // If permission has not been requested, request it
    if (status == TrackingStatus.notDetermined) {
      await AppTrackingTransparency.requestTrackingAuthorization();
    }

    // Log or handle the status (e.g., show a message if permission is denied)
    debugPrint("Tracking status: $status");
  }
}
