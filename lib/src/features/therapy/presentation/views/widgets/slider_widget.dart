import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/manager/color_manager.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/viewmodels/therapy_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliderWidget extends ConsumerWidget {
  final double sliderValue;
  final int sliderNum;
  final ChangeNotifierProvider<TherapyViewModel> therapyViewModelProvider;

  const SliderWidget(
      {super.key,
      required this.sliderValue,
      required this.therapyViewModelProvider,
      required this.sliderNum});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final therapyViewModel = ref.watch(therapyViewModelProvider);
    final colorMode = ref.watch(colorModeProvider);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "1",
                style: PoppinsStyles.semiBold(
                    color:
                    AppColorHelper.getPrimaryTextColor(colorMode)).copyWith(fontSize: 13.sp),
              ),
              Expanded(
                child: Slider(
                  value: sliderValue,
                  min: 1,
                  max: 10,
                  inactiveColor: const Color(0xffE7E9F3),
                  divisions: 9,
                  label: "$sliderValue",
                  thumbColor: AppColors.primaryColor,
                  activeColor: AppColors.primaryColor,
                  onChanged: (value) {
                    therapyViewModel.changeSlider(sliderNum, value);
                  },
                ),
              ),
              Text(
                "10",
                style: PoppinsStyles.bold(
                        color: AppColorHelper.getPrimaryTextColor(colorMode))
                    .copyWith(fontSize: 13.sp),
              ),
            ],
          ),
          RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "${sliderValue.toInt()}",
                    style: PoppinsStyles.bold(
                            color:
                                AppColorHelper.getTertiaryTextColor(colorMode))
                        .copyWith(fontSize: 16.sp),
                  ),
                  TextSpan(
                    text: "/10",
                    style: PoppinsStyles.regular(
                            color:
                                AppColorHelper.getTertiaryTextColor(colorMode))
                        .copyWith(fontSize: 16.sp),
                  ),
                ],
              )),
          20.verticalSpace,
        ],
      ),
    );
  }
}
