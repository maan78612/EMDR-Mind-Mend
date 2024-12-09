import 'package:emdr_mindmend/src/core/enums/stats_status.dart';

class UserStatsModel {
  final int dayStreak;
  final Duration totalOnlineTime;
  final DateTime? lastLoginDate;
  final int totalSessionCount;
  final StatsStatus selectedStatsStatus;

  const UserStatsModel({
    required this.dayStreak,
    required this.totalOnlineTime,
    required this.lastLoginDate,
    required this.totalSessionCount,
    required this.selectedStatsStatus,
  });

  factory UserStatsModel.empty() {
    return UserStatsModel(
      dayStreak: 0,
      totalOnlineTime: Duration.zero,
      lastLoginDate: null,
      totalSessionCount: 0,
      selectedStatsStatus: StatsStatus.today,
    );
  }

  UserStatsModel copyWith({
    int? dayStreak,
    Duration? totalOnlineTime,
    DateTime? lastLoginDate,
    int? totalSessionCount,
    StatsStatus? selectedStatsStatus,
  }) {
    return UserStatsModel(
      dayStreak: dayStreak ?? this.dayStreak,
      totalOnlineTime: totalOnlineTime ?? this.totalOnlineTime,
      lastLoginDate: lastLoginDate ?? this.lastLoginDate,
      totalSessionCount: totalSessionCount ?? this.totalSessionCount,
      selectedStatsStatus: selectedStatsStatus ?? this.selectedStatsStatus,
    );
  }
}
