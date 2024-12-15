import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/enums/stats_status.dart';
import 'package:emdr_mindmend/src/core/manager/color_manager.dart';
import 'package:emdr_mindmend/src/features/user_stats/domain/models/user_stats_model.dart';
import 'package:emdr_mindmend/src/features/user_stats/presentation/viewmodels/user_stats_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusBar extends ConsumerWidget {
  final ChangeNotifierProvider<UserStatsViewModel> userStatsNotifierProvider;

  const StatusBar({super.key, required this.userStatsNotifierProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStats = ref.watch(userStatsNotifierProvider);

    return Container(
      padding: EdgeInsets.all(8.sp),
      margin: EdgeInsets.symmetric(horizontal: 8.sp),
      decoration: BoxDecoration(
        color: const Color(0xffB4E8CF),
        borderRadius: BorderRadius.all(Radius.circular(100.r)),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: StatsStatus.values.map((status) {
            return StatusButton(
              status: status,
              isSelected: userStats.selectedStatsStatus == status,
              onTap: () {
                userStats.selectStatsStatus(status);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class StatusButton extends StatelessWidget {
  final StatsStatus status;
  final bool isSelected;
  final VoidCallback onTap;

  const StatusButton({
    super.key,
    required this.status,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: status == StatsStatus.month ? 0 : 5.sp),
        height: 35.h,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.whiteColor : Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(100.r)),
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Center(
            child: Text(
              statusToString(status),
              style: PoppinsStyles.regular(
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.greyColor)
                  .copyWith(fontSize: 14.sp),
            ),
          ),
        ),
      ),
    );
  }

  String statusToString(StatsStatus status) {
    switch (status) {
      case StatsStatus.today:
        return 'Today';
      case StatsStatus.week:
        return 'Week';
      case StatsStatus.month:
        return 'Month';

      default:
        return "";
    }
  }
}
