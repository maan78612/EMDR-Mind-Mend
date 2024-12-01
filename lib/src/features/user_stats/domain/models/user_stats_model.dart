import 'package:flutter/material.dart';

class UserStatsModel {
  final int dayStreak;
  final Duration totalOnlineTime; // Duration of total online time
  final DateTime? lastLoginDate;
  final int totalSessionCount; // Accumulative session count

  const UserStatsModel({
    required this.dayStreak,
    required this.totalOnlineTime,
    required this.lastLoginDate,
    required this.totalSessionCount,
  });

  /// Factory method to create an instance from JSON
  factory UserStatsModel.fromJson(Map<String, dynamic> json) {
    return UserStatsModel(
      dayStreak: json['dayStreak'] ?? 0,
      totalOnlineTime: _parseIso8601Duration(json['totalOnlineTime'] ?? 'PT0S'),
      lastLoginDate: json['lastLoginDate'] != null
          ? DateTime.tryParse(json['lastLoginDate'])
          : null,
      totalSessionCount: json['totalSessionCount'] ?? 0, // Added for total session count
    );
  }

  /// Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'dayStreak': dayStreak,
      'totalOnlineTime': _durationToIso8601(totalOnlineTime),
      'lastLoginDate': lastLoginDate?.toIso8601String(),
      'totalSessionCount': totalSessionCount, // Added to JSON
    };
  }

  /// Method to create a copy of the instance with modified values
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

  /// Factory method to create an empty instance with default values
  static UserStatsModel empty() {
    return UserStatsModel(
      dayStreak: 0,
      totalOnlineTime: Duration.zero,
      lastLoginDate: null,
      totalSessionCount: 0,
    );
  }

  // Helper to parse ISO 8601 duration strings into Duration
  static Duration _parseIso8601Duration(String iso8601String) {
    final regex = RegExp(r'^PT(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?$');
    final match = regex.firstMatch(iso8601String);

    if (match == null) return Duration.zero;

    final hours = int.tryParse(match.group(1) ?? '0') ?? 0;
    final minutes = int.tryParse(match.group(2) ?? '0') ?? 0;
    final seconds = int.tryParse(match.group(3) ?? '0') ?? 0;

    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }

  // Helper to convert a Duration to an ISO 8601 string
  static String _durationToIso8601(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    return 'PT'
        '${hours > 0 ? '${hours}H' : ''}'
        '${minutes > 0 ? '${minutes}M' : ''}'
        '${seconds > 0 ? '${seconds}S' : ''}';
  }

  /// Method to calculate average online time
  Duration get averageOnlineTime {
    if (totalSessionCount == 0) return Duration.zero;
    return totalOnlineTime ~/ totalSessionCount;
  }
}
