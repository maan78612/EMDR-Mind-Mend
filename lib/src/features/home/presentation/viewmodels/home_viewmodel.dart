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

  List<SubscriptionModel> subscriptionList = [];

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
}
