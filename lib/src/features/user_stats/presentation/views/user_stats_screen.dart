import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emdr_mindmend/src/features/user_stats/domain/models/user_stats_model.dart';
import 'package:emdr_mindmend/src/features/user_stats/presentation/viewmodels/user_stats_viewmodel.dart';

class UserStatsScreen extends ConsumerWidget {
  UserStatsScreen({super.key});

  final userStatsNotifierProvider =
      StateNotifierProvider<UserStatsNotifier, UserStatsModel>((ref) {
    return UserStatsNotifier();
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStats = ref.watch(userStatsNotifierProvider);
    final userStatsNotifier = ref.read(userStatsNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text("User Stats")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Day Streak: ${userStats.dayStreak}"),
          Text(
              "Total Online Time: ${userStats.totalOnlineTime.inMinutes} minutes"),
          Text(
              "Last Login Date: ${userStats.lastLoginDate?.toLocal().toString() ?? 'Never'}"),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              final currentLoginTime = DateTime.now();
              final sessionTime = const Duration(minutes: 30);
              await userStatsNotifier.updateStats(
                  currentLoginTime, sessionTime);
            },
            child: const Text("Simulate Login"),
          ),
        ],
      ),
    );
  }
}
