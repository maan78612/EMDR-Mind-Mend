import 'package:emdr_mindmend/src/core/constants/api_urls.dart';
import 'package:emdr_mindmend/src/core/services/network/api_data_source.dart';
import 'package:emdr_mindmend/src/features/user_stats/domain/models/user_stats_model.dart';
import 'package:emdr_mindmend/src/features/user_stats/domain/repositories/user_stats_repository.dart';

class UserStatsRepositoryImpl implements UserStatsRepository {
  @override
  Future<void> saveUserStats(UserStatsModel userStats) async {
    try {
      final value = await NetworkApi.instance.post(url: ApiUrls.userStats, body: userStats.toJson());
      // return UserStatsModel.fromJson(value["data"]);
    } catch (e) {
      rethrow;
    }
  }



  @override
  Future<UserStatsModel> fetchUserStats() async {
    try {
      final value = await NetworkApi.instance.get(url: ApiUrls.userStats);
      return UserStatsModel.fromJson(value["data"]);
    } catch (e) {
      rethrow;
    }
  }
}
