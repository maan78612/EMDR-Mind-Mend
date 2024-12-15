import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/enums/snackbar_status.dart';
import 'package:emdr_mindmend/src/core/services/stripe/stripe_methods.dart';
import 'package:emdr_mindmend/src/features/auth/domain/models/user.dart';
import 'package:emdr_mindmend/src/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:emdr_mindmend/src/features/dashboard/domain/models/subscription.dart';
import 'package:emdr_mindmend/src/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubscriptionViewModel with ChangeNotifier {
  final DashBoardRepository _dashBoardRepository = DashBoardRepositoryImpl();
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

  GetSubscriptionModel? selectedSubscription;
  List<GetSubscriptionModel> subscriptionList = [];

  void initMethod(List<GetSubscriptionModel> subscriptionList) {
    this.subscriptionList = subscriptionList;
    notifyListeners();
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

  Future<void> setSubscription({
    required Function({
      required SnackBarType snackType,
      required String message,
    }) showSnackBarMsg,
    required WidgetRef ref,
  }) async {
    try {
      setLoading(true);
      if (selectedSubscription?.id != "1") {
        debugPrint(selectedSubscription?.amount.toString());
        await PaymentService().makePayment(
            amount: ((selectedSubscription?.amount ?? 0.0)),
            userName: ref.read(userModelProvider).name);
      }

      final body = {"subscription_id": selectedSubscription?.id};
      final data = await _dashBoardRepository.setSubscription(body: body);

      _setSubscriptionDataLocally(data, ref);

      notifyListeners();
      CustomNavigation().pop();

      showSnackBarMsg(
          message: selectedSubscription?.id != "1"
              ? "Subscribed successfully"
              : "Free trail started",
          snackType: SnackBarType.success);
    } catch (e) {
      debugPrint(e.toString());
      showSnackBarMsg(message: e.toString(), snackType: SnackBarType.error);
    } finally {
      setLoading(false);
    }
  }

  void _setSubscriptionDataLocally(data, WidgetRef ref) {
    final subscription = Subscription.fromJson(data['subscription']);

    final isTrialValid = data['isTrialValid'];

    ref.read(userModelProvider.notifier).updateIsTrialValid(isTrialValid);
    ref.read(userModelProvider.notifier).updateSubscription(subscription);
  }
}
