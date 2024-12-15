import 'package:emdr_mindmend/src/core/commons/loader.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/constants/images.dart';
import 'package:emdr_mindmend/src/core/enums/color_enum.dart';
import 'package:emdr_mindmend/src/core/manager/color_manager.dart';
import 'package:emdr_mindmend/src/features/user_stats/presentation/views/widgets/status_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserStatsScreen extends ConsumerStatefulWidget {
  const UserStatsScreen({super.key});

  @override
  ConsumerState<UserStatsScreen> createState() => _UserStatsScreenState();
}

class _UserStatsScreenState extends ConsumerState<UserStatsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userStatsViewModelProvider).loadUserStats();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorMode = ref.watch(colorModeProvider);
    final userStatsViewModel = ref.watch(userStatsViewModelProvider);
    return CustomLoader(
      isLoading: userStatsViewModel.isLoading,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColorHelper.getScaffoldColor(colorMode),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.verticalSpace,
                Text(
                  'Welcome Back, ${ref.read(userModelProvider).name}',
                  style: PoppinsStyles.bold(
                          color: AppColorHelper.getPrimaryTextColor(colorMode))
                      .copyWith(fontSize: 18.sp),
                ),
                40.verticalSpace,
                StatusBar(
                    userStatsNotifierProvider: userStatsViewModelProvider),
                40.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStatCard(
                        title: 'Day streak',
                        colorMode: colorMode,
                        value: RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    "${userStatsViewModel.userStats.dayStreak}",
                                style: PoppinsStyles.bold(
                                        color:
                                            AppColorHelper.getPrimaryTextColor(
                                                colorMode))
                                    .copyWith(fontSize: 32.sp),
                              ),
                              TextSpan(
                                text: " days",
                                style: PoppinsStyles.regular(
                                        color:
                                            AppColorHelper.getPrimaryTextColor(
                                                colorMode))
                                    .copyWith(fontSize: 14.sp),
                              ),
                            ],
                          ),
                        ),
                        icon: AppImages.streak,
                        image: Image.asset(
                          width: 116.w,
                          height: 50.h,
                          AppImages.dayStreak,
                        )),
                    10.horizontalSpace,
                    _buildStatCard(
                        title: 'Total time',
                        colorMode: colorMode,
                        value: Text(
                          formatDuration(
                              userStatsViewModel.userStats.totalOnlineTime),
                          style: PoppinsStyles.bold(
                                  color: AppColorHelper.getPrimaryTextColor(
                                      colorMode))
                              .copyWith(fontSize: 24.sp),
                        ),
                        icon: AppImages.time,
                        image: Image.asset(
                          width: 80.w,
                          height: 80.h,
                          AppImages.totalTime,
                        )),
                  ],
                ),
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStatCard(
                        title: 'Average time',
                        colorMode: colorMode,
                        value: Text(
                          textAlign: TextAlign.start,
                          formatDuration(userStatsViewModel.calculateAverageTimePerDay()),
                          style: PoppinsStyles.bold(
                                  color: AppColorHelper.getPrimaryTextColor(
                                      colorMode))
                              .copyWith(fontSize: 24.sp),
                        ),
                        icon: AppImages.time,
                        image: Image.asset(
                          width: 60.w,
                          height: 60.w,
                          AppImages.avgTime,
                        )),
                    10.horizontalSpace,
                    _buildStatCard(
                        title: 'Before vs after',
                        colorMode: colorMode,
                        value: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${userStatsViewModel.improvementValue} ",
                              style: PoppinsStyles.bold(
                                      color: AppColorHelper.getPrimaryTextColor(
                                          colorMode))
                                  .copyWith(fontSize: 32.sp),
                            ),
                            Expanded(
                              child: Text(
                                "point\nimprovement",
                                style: PoppinsStyles.regular(
                                        color:
                                            AppColorHelper.getPrimaryTextColor(
                                                colorMode))
                                    .copyWith(fontSize: 12.sp),
                              ),
                            )
                          ],
                        ),
                        icon: AppImages.graph,
                        image: Image.asset(
                          width: 118.w,
                          AppImages.beforeAfter,
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
      {required String title,
      required Widget value,
      required String icon,
      required Widget image,
      required ColorMode colorMode}) {
    return Container(
      height: 200.h,
      width: 150.w,
      decoration: BoxDecoration(
        color: AppColorHelper.cardColor(colorMode),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(12.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                icon,
                height: 18.sp,
                width: 18.sp,
                color: AppColorHelper.getSecondaryTextColor(colorMode),
              ),
              8.horizontalSpace,
              Text(
                title,
                style: PoppinsStyles.medium(
                        color: AppColorHelper.getPrimaryTextColor(colorMode))
                    .copyWith(fontSize: 12.sp),
              ),
            ],
          ),
          const Spacer(),
          Center(child: image),
          const Spacer(),
          value,
        ],
      ),
    );
  }

  String formatDuration(Duration duration) {
    int totalDays = duration.inDays;
    int years = totalDays ~/ 365;
    int months = (totalDays % 365) ~/ 30;
    int days = totalDays % 365 % 30;
    int hours = duration.inHours.remainder(24);
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    // List of all time components with labels
    List<String> parts = [];
    if (years > 0) parts.add("$years year${years > 1 ? 's' : ''}");
    if (months > 0) parts.add("$months month${months > 1 ? 's' : ''}");
    if (days > 0) parts.add("$days day${days > 1 ? 's' : ''}");
    if (hours > 0) parts.add("$hours hour${hours > 1 ? 's' : ''}");
    if (minutes > 0) parts.add("$minutes min${minutes > 1 ? 's' : ''}");
    if (seconds >= 0) parts.add("$seconds sec${seconds > 1 ? 's' : ''}");

    // Return only the top two units
    return parts.take(2).join(" ");
  }
}
