import 'package:emdr_mindmend/src/features/user_stats/domain/models/user_stats_model.dart';

abstract class UserStatsRepository {
  Future<void> saveUserStats(UserStatsModel userStats);
  Future<UserStatsModel> fetchUserStats();

}
