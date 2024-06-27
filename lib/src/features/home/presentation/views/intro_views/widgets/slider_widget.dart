import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/features/home/presentation/viewmodels/intro_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliderWidget extends ConsumerWidget {
  double sliderValue;
  int sliderNum;
  ChangeNotifierProvider<IntroViewModel> introViewModelProvider;
  SliderWidget({super.key, required this.sliderValue,required this.introViewModelProvider,required this.sliderNum});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final introViewModel = ref.watch(introViewModelProvider);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Row(
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
    );
  }
}
