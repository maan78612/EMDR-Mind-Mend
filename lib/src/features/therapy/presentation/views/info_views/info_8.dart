import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/enums/color_enum.dart';
import 'package:emdr_mindmend/src/core/manager/color_manager.dart';
import 'package:emdr_mindmend/src/features/settings/presentation/viewmodels/setting_viewmodel.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/viewmodels/therapy_viewmodel.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/info_views/pendulum_animation_screen.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/widgets/info_description.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/widgets/info_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Info8 extends ConsumerWidget {
  final ChangeNotifierProvider<TherapyViewModel> therapyViewModelProvider;

  const Info8({super.key, required this.therapyViewModelProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final therapyViewModel = ref.watch(therapyViewModelProvider);
    final settingViewModel = ref.watch(settingViewModelProvider);
    final colorMode = ref.watch(colorModeProvider);
    return ListView(
      children: [
        const infoHeading(heading: 'Desensitisation'),
        Container(
          decoration: BoxDecoration(
              color: const Color(0xfff1f1f3),
              borderRadius: BorderRadius.all(Radius.circular(20.r))),
          child: Row(
              children: List.generate(
                  therapyViewModel.desensitisationList.length, (index) {
            return settingOptionWidget(
                title: therapyViewModel.desensitisationList[index],
                therapyViewModel: therapyViewModel,
                settingViewModel: settingViewModel,
                colorMode: colorMode);
          })),
        ),
        40.verticalSpace,
        therapyViewModel.selectedDesensitisation == "Auditory"
            ? auditory(settingViewModel, colorMode)
            : visual(settingViewModel),
      ],
    );
  }

  Widget auditory(SettingViewModel settingViewModel, ColorMode colorMode) {
    return Column(
      children: [
        const InfoDescriptionWidget(descriptions: [
          "Bilateral visual stimulation is ideal for processing most traumatic memories, while bilateral auditory stimulation is prefred if you have a severe visual impairment."
        ]),
        30.verticalSpace,
        const InfoDescriptionWidget(descriptions: [
          "We strongly recommend that you use headphones or earphones for auditory stimulation. As you listen, please focus on the moment of the event that generated the emotion. Let the thoughts run through your mind, without judging their relevance"
        ]),
        40.verticalSpace,
        settingViewModel.isPlaying
            ? stopButton(
                settingViewModel: settingViewModel,
                stopFunc: () => settingViewModel.stopSound(),
                colorMode: colorMode)
            : playButton(
                settingViewModel: settingViewModel,
                playFunc: () => settingViewModel.playSound()),
      ],
    );
  }

  Widget visual(SettingViewModel settingViewModel) {
    return Column(
      children: [
        const InfoDescriptionWidget(
            descriptions: ["This is where we use the desensitisation "]),
        40.verticalSpace,
        playButton(
            settingViewModel: settingViewModel,
            playFunc: () => CustomNavigation().push(const PendulumAnimation())),
      ],
    );
  }

  Widget stopButton(
      {required SettingViewModel settingViewModel,
      required Function stopFunc,
      required ColorMode colorMode}) {
    return CommonInkWell(
      onTap: () => stopFunc(),
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
              const Icon(Icons.stop_circle, color: AppColors.redColor),
              Text(
                "Stop",
                style: PoppinsStyles.bold(
                        color: AppColorHelper.getPrimaryTextColor(colorMode))
                    .copyWith(fontSize: 16, color: AppColors.redColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CommonInkWell playButton(
      {required SettingViewModel settingViewModel,
      required Function playFunc}) {
    return CommonInkWell(
      onTap: () => playFunc(),
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
            const Icon(Icons.play_arrow, color: AppColors.primaryColor),
            Text(
              "Play",
              style: PoppinsStyles.bold(color: AppColors.primaryColor)
                  .copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget settingOptionWidget(
      {required String title,
      required TherapyViewModel therapyViewModel,
      required SettingViewModel settingViewModel,
      required ColorMode colorMode}) {
    return Expanded(
      child: CommonInkWell(
        onTap: () {
          if (settingViewModel.isPlaying) {
            settingViewModel.stopSound();
          }

          therapyViewModel.setDesensitisation(title);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.sp),
          margin: EdgeInsets.all(4.sp),
          decoration: title == therapyViewModel.selectedDesensitisation
              ? BoxDecoration(
                  color: AppColorHelper.getScaffoldColor(colorMode),
                  borderRadius: BorderRadius.all(Radius.circular(30.r)))
              : const BoxDecoration(),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: title == therapyViewModel.selectedDesensitisation
                ? PoppinsStyles.semiBold(color: AppColors.primaryColor)
                    .copyWith(fontSize: 14.sp)
                : PoppinsStyles.regular(color: AppColors.greyColor)
                    .copyWith(fontSize: 14.sp),
          ),
        ),
      ),
    );
  }
}
