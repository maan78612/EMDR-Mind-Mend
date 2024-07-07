import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/features/home/presentation/viewmodels/info_viewmodel.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/info_views/widgets/intro_description.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/info_views/widgets/intro_heading.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/info_views/widgets/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Intro6 extends ConsumerWidget {
  final ChangeNotifierProvider<IntroViewModel> introViewModelProvider;

  const Intro6({super.key, required this.introViewModelProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final introViewModel = ref.watch(introViewModelProvider);
    return ListView(
      children: [
        const IntroHeading(heading: 'General emotion'),
        const IntroDescription(
          isBullet: true,
          description:
              "As you are going through images and feeling in your head- how many moments did you feel? (mark this from 1-10 below)",
        ),
        70.verticalSpace,
        SliderWidget(
          sliderValue: introViewModel.generalEmotion,
          introViewModelProvider: introViewModelProvider,
          sliderNum: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "(no disturbance/neutral)",
              style: PoppinsStyles.light.copyWith(fontSize: 10.sp,color: const Color(0xff424242)),
            ),
            Text(
              "(highest disturbance)",
              style: PoppinsStyles.light.copyWith(fontSize: 10.sp,color: const Color(0xff424242)),
            )
          ],
        )
      ],
    );
  }
}
