import 'package:emdr_mindmend/src/features/home/domain/models/subscription.dart';

abstract class HomeRepository {
  Future<void> sendScore({required Map<String, dynamic> body});

  Future<void> getScore();

  Future<List<GetSubscriptionModel>> getSubscription();

  Future<dynamic> setSubscription({required Map<String, dynamic> body});

  Future<void> setTutorialShowedOnce();

  Future<bool> isTutorialAlreadyShown();
}
