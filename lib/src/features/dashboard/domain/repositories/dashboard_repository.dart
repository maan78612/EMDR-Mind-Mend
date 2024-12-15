import 'package:emdr_mindmend/src/features/dashboard/domain/models/subscription.dart';


abstract class DashBoardRepository {


  Future<List<GetSubscriptionModel>> getSubscription();

  Future<dynamic> setSubscription({required Map<String, dynamic> body});


}
