class UserStatsModel {
  final int dayStreak;
  final Duration totalOnlineTime;
  final DateTime? lastLoginDate;
  final int totalSessionCount;

  const UserStatsModel({
    required this.dayStreak,
    required this.totalOnlineTime,
    required this.lastLoginDate,
    required this.totalSessionCount,
  });

  factory UserStatsModel.empty() {
    return const UserStatsModel(
      dayStreak: 0,
      totalOnlineTime: Duration.zero,
      lastLoginDate: null,
      totalSessionCount: 0,
    );
  }

  UserStatsModel copyWith({
    int? dayStreak,
    Duration? totalOnlineTime,
    DateTime? lastLoginDate,
    int? totalSessionCount,
  }) {
    return UserStatsModel(
      dayStreak: dayStreak ?? this.dayStreak,
      totalOnlineTime: totalOnlineTime ?? this.totalOnlineTime,
      lastLoginDate: lastLoginDate ?? this.lastLoginDate,
      totalSessionCount: totalSessionCount ?? this.totalSessionCount,
    );
  }

  /// Convert a JSON map to a UserStatsModel instance
  factory UserStatsModel.fromJson(Map<String, dynamic> json) {
    return UserStatsModel(
      dayStreak: json['day_streak'] as int,
      totalOnlineTime:
          Duration(seconds: int.parse(json['total_online_time'].toString())),
      lastLoginDate: json['last_login_date'] != null
          ? DateTime.parse(json['last_login_date'])
          : null,
      totalSessionCount: int.parse(json['total_session_count'].toString()),
    );
  }

  /// Convert a UserStatsModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'day_streak': dayStreak,
      'total_online_time': totalOnlineTime.inSeconds,
      'last_login_date': lastLoginDate?.toIso8601String(),
      'total_session_count': totalSessionCount,
    };
  }
}
