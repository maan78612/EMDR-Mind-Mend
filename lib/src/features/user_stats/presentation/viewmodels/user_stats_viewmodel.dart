import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emdr_mindmend/src/features/user_stats/data/repositories/user_stats_repository_impl.dart';
import 'package:emdr_mindmend/src/features/user_stats/domain/models/user_stats_model.dart';
import 'package:emdr_mindmend/src/features/user_stats/domain/repositories/user_stats_repository.dart';

class UserStatsNotifier extends StateNotifier<UserStatsModel> {
  final UserStatsRepository _userStatsRepository = UserStatsRepositoryImpl();

  UserStatsNotifier() : super(UserStatsModel.empty());

  Future<void> loadUserStats() async {
    final userStats = await _userStatsRepository.fetchUserStats();

    state = userStats;
  }

  Future<void> updateStats(DateTime currentLoginTime, Duration sessionTime) async {
    int newDayStreak = state.dayStreak;
    int newTotalSessionCount = state.totalSessionCount;

    if (state.lastLoginDate != null) {
      final lastLoginDate = state.lastLoginDate!;
      final differenceInDays = currentLoginTime.difference(lastLoginDate).inDays;

      if (differenceInDays == 1) {
        // Consecutive day login, increment streak
        newDayStreak++;
      } else if (differenceInDays > 1) {
        // More than 1 day gap, reset streak
        newDayStreak = 1;
      }
    } else {
      newDayStreak = 1; // First-time login
    }

    // Update total online time and session count
    final updatedTotalOnlineTime = state.totalOnlineTime + sessionTime;
    newTotalSessionCount++;

    // Update the state
    state = state.copyWith(
      dayStreak: newDayStreak,
      totalOnlineTime: updatedTotalOnlineTime,
      lastLoginDate: currentLoginTime,
      totalSessionCount: newTotalSessionCount, // Increment session count
    );

    // Save updated stats to the repository
    await _userStatsRepository.saveUserStats(state);
  }

}
