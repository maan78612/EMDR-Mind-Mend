import 'package:emdr_mindmend/src/core/constants/api_urls.dart';
import 'package:emdr_mindmend/src/core/services/network/api_data_source.dart';
import 'package:emdr_mindmend/src/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:emdr_mindmend/src/features/home/domain/models/subscription.dart';

class DashBoardRepositoryImpl implements DashBoardRepository {



  @override
  Future<List<GetSubscriptionModel>> getSubscription() async {
    try {
      var response =
          await NetworkApi.instance.get(url: ApiUrls.getSubscription);
      return List<GetSubscriptionModel>.from(
          response["data"].map((x) => GetSubscriptionModel.fromJson(x)));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> setSubscription({required Map<String, dynamic> body}) async {
    try {
      final data = await NetworkApi.instance
          .post(url: ApiUrls.setSubscription, body: body);
      return data['data'];
    } catch (e) {
      rethrow;
    }
  }


}
