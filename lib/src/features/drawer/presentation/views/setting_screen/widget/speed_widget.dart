import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/enums/setting_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpeedWidget extends ConsumerWidget {
  final SettingSlider slider;

  const SpeedWidget({super.key, required this.slider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              value: slider == SettingSlider.auditory
                  ? settingViewModel.auditorySpeed
                  : settingViewModel.visualSpeed,
              min: 1,
              max: 5,
              inactiveColor: const Color(0xffE7E9F3),
              divisions: 4,
              thumbColor: settingViewModel.getColor(settingViewModel.ballColor),
              activeColor:
                  settingViewModel.getColor(settingViewModel.ballColor),
              onChanged: (value) {
                slider == SettingSlider.auditory
                    ? settingViewModel.setAuditorySpeed(value)
                    : settingViewModel.setVisualSpeed(value);
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
