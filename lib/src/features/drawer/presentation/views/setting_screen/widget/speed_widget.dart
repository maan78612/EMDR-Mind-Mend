import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SpeedWidget extends ConsumerWidget {


  const SpeedWidget({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final settingViewModel = ref.watch(settingViewModelProvider);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Row(
        children: [
          Text("Speed",
              style: PoppinsStyles.semiBold.copyWith(fontSize: 22.sp)),
          SizedBox(width: 10.w),
          Text(
            "1",
            style: PoppinsStyles.semiBold.copyWith(fontSize: 13.sp),
          ),
          Expanded(
            child: Slider(
              value: settingViewModel.speed,
              min: 1,
              max: 5,
              inactiveColor: const Color(0xffE7E9F3),
              divisions: 4,
              thumbColor: settingViewModel.getColor(settingViewModel.ballColor),
              activeColor:
                  settingViewModel.getColor(settingViewModel.ballColor),
              onChanged: (value) {
                settingViewModel.setSpeed(value);
              },
            ),
          ),
          Text(
            "5",
            style: PoppinsStyles.semiBold.copyWith(fontSize: 13.sp),
          ),
        ],
      ),
    );
  }
}
