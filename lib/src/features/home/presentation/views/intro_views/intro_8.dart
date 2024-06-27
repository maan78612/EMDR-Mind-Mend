import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/features/home/presentation/viewmodels/intro_viewmodel.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/intro_views/widgets/intro_description.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/intro_views/widgets/intro_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Intro8 extends ConsumerWidget {
  final ChangeNotifierProvider<IntroViewModel> introViewModelProvider;

  const Intro8({super.key, required this.introViewModelProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final introViewModel = ref.watch(introViewModelProvider);
    final settingViewModel = ref.watch(settingViewModelProvider);
    return ListView(
      children: [
        const IntroHeading(heading: 'Desensitisation'),
        Container(
          decoration: BoxDecoration(
              color: const Color(0xfff1f1f3),
              borderRadius: BorderRadius.all(Radius.circular(20.r))),
          child: Row(
              children: List.generate(introViewModel.desensitisationList.length,
                  (index) {
            return settingOptionWidget(
                title: introViewModel.desensitisationList[index],
                introViewModel: introViewModel);
          })),
        ),
        40.verticalSpace,
        const IntroDescription(
            description: "This is where we use the desensitisation "),
        40.verticalSpace,
        settingViewModel.isPlaying
            ? CommonInkWell(
                onTap: () {
                  settingViewModel.stopSound();
                },
                child: Center(
                  child: Container(
                    width: 110.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.redColor),
                        borderRadius: BorderRadius.all(Radius.circular(10.r))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.stop_circle,
                            color: AppColors.redColor),
                        Text(
                          "Stop",
                          style: PoppinsStyles.bold.copyWith(
                              fontSize: 16, color: AppColors.redColor),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Center(
                child: CommonInkWell(
                  onTap: () => settingViewModel.playSound(),
                  child: Container(
                    width: 110.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(10.r))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.play_arrow,
                            color: AppColors.primaryColor),
                        Text(
                          "Play",
                          style: PoppinsStyles.bold.copyWith(
                              fontSize: 16, color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              )
      ],
    );
  }

  Widget settingOptionWidget(
      {required String title, required IntroViewModel introViewModel}) {
    return Expanded(
      child: CommonInkWell(
        onTap: () {
          introViewModel.setDesensitisation(title);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.sp),
          margin: EdgeInsets.all(4.sp),
          decoration: title == introViewModel.selectedDesensitisation
              ? BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(30.r)))
              : const BoxDecoration(),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: title == introViewModel.selectedDesensitisation
                ? PoppinsStyles.semiBold
                    .copyWith(fontSize: 14.sp, color: AppColors.primaryColor)
                : PoppinsStyles.regular
                    .copyWith(fontSize: 14.sp, color: AppColors.greyColor),
          ),
        ),
      ),
    );
  }
}
