import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/constants/images.dart';
import 'package:emdr_mindmend/src/core/enums/color_ball.dart';
import 'package:emdr_mindmend/src/core/enums/setting_slider.dart';
import 'package:emdr_mindmend/src/core/manager/color_manager.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/views/setting_screen/widget/speed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VisualTab extends ConsumerWidget {
  const VisualTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingViewModel = ref.watch(settingViewModelProvider);
    final colorMode = ref.watch(colorModeProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        30.verticalSpace,
        const SpeedWidget(slider: SettingSlider.visual),
        30.verticalSpace,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 8.sp),
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              border: Border.all(color: AppColors.borderColor),
              borderRadius: BorderRadius.all(Radius.circular(10.r))),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: settingViewModel
                            .getColor(settingViewModel.ballColor),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  3.horizontalSpace,
                  Image.asset(AppImages.right),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(child: Image.asset(AppImages.left)),
                  3.horizontalSpace,
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color:
                          settingViewModel.getColor(settingViewModel.ballColor),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        10.verticalSpace,
        Text(
          "Example",
          style: PoppinsStyles.light(
                  color: AppColorHelper.getPrimaryTextColor(colorMode))
              .copyWith(fontSize: 14.sp),
        ),
        25.verticalSpace,
         Divider(color:AppColorHelper.dividerColor(colorMode)),
        25.verticalSpace,
        Row(
          children: [
            Text(
              "Color",
              style: PoppinsStyles.semiBold(
                      color: AppColorHelper.getPrimaryTextColor(colorMode))
                  .copyWith(fontSize: 22.sp),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: BallColor.values
                    .map((color) => GestureDetector(
                          onTap: () {
                            settingViewModel.setBallColor(color);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: settingViewModel.getColor(color),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
        20.verticalSpace,
        Row(
          children: [
            Text(
              "Background Color",
              style: PoppinsStyles.semiBold(
                      color: AppColorHelper.getPrimaryTextColor(colorMode))
                  .copyWith(fontSize: 22.sp),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  List.generate(settingViewModel.bgColorList.length, (index) {
                Color bgColor = settingViewModel.bgColorList[index];
                return GestureDetector(
                  onTap: () {
                    settingViewModel.setBgColor(bgColor);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: bgColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 2,
                              color: bgColor == settingViewModel.bgColor
                                  ? AppColors.primaryColor
                                  : Colors.transparent)),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ],
    );
  }
}
