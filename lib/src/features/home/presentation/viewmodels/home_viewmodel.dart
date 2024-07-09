
import 'package:emdr_mindmend/src/core/enums/snackbar_status.dart';
import 'package:emdr_mindmend/src/features/home/data/repositories/home_repository_impl.dart';
import 'package:emdr_mindmend/src/features/home/domain/models/subscription.dart';
import 'package:emdr_mindmend/src/features/home/domain/repositories/home_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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

  List<SubscriptionModel> subscriptionList = [];

  SubscriptionModel? selectedSubscription;

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
      // if (selectedSubscription?.id != "1") {
      //   await PaymentService().makePayment(amount: '1');
      // }

      setLoading(true);
      final body = {"subscription_id": selectedSubscription?.id};
      await _homeRepository.setSubscription(body: body);
    } catch (e) {
      showSnackBarMsg(message: e.toString(), snackType: SnackBarType.error);
    } finally {
      setLoading(false);
    }
  }

  void selectSubscription(SubscriptionModel selectedSubscription) {
    if (selectedSubscription != this.selectedSubscription) {
      this.selectedSubscription = selectedSubscription;
    } else {
      this.selectedSubscription = null;
    }
    setEnableBtn();
  }

  void setEnableBtn() {
    if (selectedSubscription != null) {
      _isBtnEnable = true;
    } else {
      _isBtnEnable = false;
    }

    notifyListeners();
  }
}
