import 'package:emdr_mindmend/src/features/user_stats/domain/models/user_stats_model.dart';
import 'package:emdr_mindmend/src/features/user_stats/domain/repositories/user_stats_repository.dart';


class UserStatsRepositoryImpl implements UserStatsRepository {


  @override
  Future<void> saveUserStats(UserStatsModel userStats) async {

  }

  @override
  Future<UserStatsModel> fetchUserStats() async {
    return UserStatsModel.empty();
  }
}
