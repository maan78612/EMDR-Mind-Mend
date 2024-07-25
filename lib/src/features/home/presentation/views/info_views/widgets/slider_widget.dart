import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/features/home/presentation/viewmodels/info_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliderWidget extends ConsumerWidget {
  final double sliderValue;
  final int sliderNum;
  final ChangeNotifierProvider<IntroViewModel> introViewModelProvider;

  const SliderWidget(
      {super.key,
      required this.sliderValue,
      required this.introViewModelProvider,
      required this.sliderNum});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final introViewModel = ref.watch(introViewModelProvider);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "1",
                style: PoppinsStyles.semiBold.copyWith(fontSize: 13.sp),
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
                    introViewModel.changeSlider(sliderNum, value);
                  },
                ),
              ),
              Text(
                "10",
                style: PoppinsStyles.semiBold.copyWith(fontSize: 13.sp),
              ),
            ],
          ),
          RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "${sliderValue.toInt()}",
                    style: PoppinsStyles.bold
                        .copyWith(fontSize: 16.sp, color: AppColors.greyColor),
                  ),
                  TextSpan(
                    text: "/10",
                    style: PoppinsStyles.regular
                        .copyWith(fontSize: 16.sp, color: AppColors.greyColor),
                  ),
                ],
              )),
          20.verticalSpace,
        ],
      ),
    );
  }
}
