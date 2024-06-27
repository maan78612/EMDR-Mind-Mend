import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/views/setting_screen/widget/speed_widget.dart';
import 'package:flutter/material.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/viewmodels/setting_viewmodel.dart'; // Make sure to update the import path
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuditoryTab extends ConsumerWidget {
  const AuditoryTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingViewModel = ref.watch(settingViewModelProvider);
    return Column(
      children: [
        toneWidget(settingViewModel),
        25.verticalSpace,
        const Divider(color: AppColors.borderColor),
        25.verticalSpace,
        const SpeedWidget(),
      ],
    );
  }

  Widget toneWidget(SettingViewModel settingViewModel) {
    return Padding(
      padding: EdgeInsets.only(top: 30.sp),
      child: Row(
        children: [
          Text("Tone", style: PoppinsStyles.semiBold.copyWith(fontSize: 22.sp)),
          20.horizontalSpace,
          Row(
            children: List.generate(settingViewModel.toneList.length, (index) {
              return CommonInkWell(
                onTap: () {
                  settingViewModel.selectTone(index);
                },
                child: Container(
                  width: settingViewModel.selectedToneIndex == index
                      ? 35.sp
                      : 30.sp,
                  height: settingViewModel.selectedToneIndex == index
                      ? 35.sp
                      : 30.sp,
                  margin: EdgeInsets.only(right: 10.h),
                  decoration: BoxDecoration(
                      color: settingViewModel.selectedToneIndex == index
                          ? settingViewModel
                              .getColor(settingViewModel.ballColor)
                          : AppColors.whiteColor,
                      shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      "${index + 1}",
                      style: settingViewModel.selectedToneIndex == index
                          ? PoppinsStyles.semiBold.copyWith(
                              fontSize: 15.sp, color: AppColors.whiteColor)
                          : PoppinsStyles.medium.copyWith(fontSize: 15.sp),
                    ),
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
