import 'package:emdr_mindmend/src/core/enums/snackbar_status.dart';
import 'package:emdr_mindmend/src/core/enums/stats_status.dart';
import 'package:emdr_mindmend/src/core/utilities/custom_snack_bar.dart';
import 'package:emdr_mindmend/src/features/therapy/data/repositories/therapy_repository_impl.dart';
import 'package:emdr_mindmend/src/features/therapy/domain/repositories/therapy_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:emdr_mindmend/src/features/user_stats/data/repositories/user_stats_repository_impl.dart';
import 'package:emdr_mindmend/src/features/user_stats/domain/models/user_stats_model.dart';
import 'package:emdr_mindmend/src/features/user_stats/domain/repositories/user_stats_repository.dart';

class UserStatsViewModel with ChangeNotifier {
  final UserStatsRepository _userStatsRepository = UserStatsRepositoryImpl();
  final TherapyRepository _therapyRepository = TherapyRepositoryImpl();

  UserStatsModel _userStats = UserStatsModel.empty();

  UserStatsModel get userStats => _userStats;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  StatsStatus _selectedStatsStatus = StatsStatus.today;

  StatsStatus get selectedStatsStatus => _selectedStatsStatus;

  int _improvementValue = 0;

  int get improvementValue => _improvementValue;

  /// Load user stats from the repository
  Future<void> loadUserStats() async {
    try {
      _setLoading(true);
      _improvementValue = await getScore();
      final userStats = await _userStatsRepository.fetchUserStats();
      _userStats = userStats;
      notifyListeners();
      await updateStreak();

      notifyListeners();
    } catch (error) {
      SnackBarUtils.show(error.toString(), SnackBarType.error);
    } finally {
      _setLoading(false);
    }
  }

  /// Update the selected stats status
  void selectStatsStatus(StatsStatus status) {
    _selectedStatsStatus = status;
    notifyListeners();
  }

  /// Update day streak and session count when the user logs in
  Future<void> updateStreak() async {
    try {
      DateTime currentLoginTime = DateTime.now();
      int newDayStreak = _userStats.dayStreak;
      int newTotalSessionCount = _userStats.totalSessionCount;
      DateTime? lastLoginDate = _userStats.lastLoginDate;

      bool shouldUpdateStats = false;
      int differenceInDays = 0;

      if (lastLoginDate != null) {
        differenceInDays = currentLoginTime.difference(lastLoginDate).inDays;
        debugPrint("lastLoginDate = $lastLoginDate");
        debugPrint("currentLoginTime = $currentLoginTime");
        debugPrint("Difference In Days = $differenceInDays");

        if (differenceInDays == 1) {
          newDayStreak++;
          shouldUpdateStats = true;
        } else if (differenceInDays > 1) {
          newDayStreak = 1; // Reset streak
          shouldUpdateStats = true;
        }
      } else {
        newDayStreak = 1; // First-time login
        shouldUpdateStats = true;
      }

      if (lastLoginDate == null || differenceInDays > 0) {
        newTotalSessionCount++;
        shouldUpdateStats = true;
      }

      if (shouldUpdateStats) {
        _userStats = _userStats.copyWith(
          dayStreak: newDayStreak,
          lastLoginDate: currentLoginTime,
          totalSessionCount: newTotalSessionCount,
        );

        await _userStatsRepository.saveUserStats(_userStats);
      }
    } catch (error) {
      rethrow;
    }
  }

  /// Calculate session time while the user is on a specific screen
  Future<void> calculateSessionTime(
      DateTime sessionStartTime, UserStatsModel userStats) async {
    try {
      final sessionEndTime = DateTime.now();
      final sessionDuration = sessionEndTime.difference(sessionStartTime);

      userStats = userStats.copyWith(
        totalOnlineTime: userStats.totalOnlineTime + sessionDuration,
      );

      notifyListeners();
      await _userStatsRepository.saveUserStats(userStats);
    } catch (error) {
      SnackBarUtils.show(error.toString(), SnackBarType.error);
    }
  }

  /// Calculate the average time per day
  Duration calculateAverageTimePerDay() {
    if (_userStats.totalSessionCount == 0) {
      return Duration.zero; // Avoid division by zero
    }

    return _userStats.totalOnlineTime ~/ _userStats.totalSessionCount;
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<int> getScore() async {
    try {
      return await _therapyRepository.getScore();
    } catch (e) {
      rethrow;
    }
  }
}
