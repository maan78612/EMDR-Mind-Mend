import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/enums/color_enum.dart';
import 'package:emdr_mindmend/src/core/manager/color_manager.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/viewmodels/setting_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingTabButtons extends ConsumerWidget {
  const SettingTabButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingViewModel = ref.watch(settingViewModelProvider);
    final colorMode = ref.watch(colorModeProvider);

    return Container(
      decoration: BoxDecoration(
          color: const Color(0xfff1f1f3),
          borderRadius: BorderRadius.all(Radius.circular(20.r))),
      child: Row(
          children:
              List.generate(settingViewModel.settingOptions.length, (index) {
        return settingOptionWidget(
            index: index,
            title: settingViewModel.settingOptions[index],
            settingViewModel: settingViewModel,
            colorMode: colorMode);
      })),
    );
  }

  Widget settingOptionWidget(
      {required int index,
      required String title,
      required SettingViewModel settingViewModel,
      required ColorMode colorMode}) {
    return Expanded(
      child: CommonInkWell(
        onTap: () {
          settingViewModel.setPageIndex(index);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.sp),
          margin: EdgeInsets.all(4.sp),
          decoration: settingViewModel.settingPageIndex == index
              ? BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(30.r)))
              : const BoxDecoration(),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: settingViewModel.settingPageIndex == index
                ? PoppinsStyles.semiBold(color: AppColors.primaryColor)
                    .copyWith(
                    fontSize: 14.sp,
                  )
                : PoppinsStyles.regular(
                        color: AppColors.greyColor)
                    .copyWith(fontSize: 14.sp),
          ),
        ),
      ),
    );
  }
}
