import 'package:emdr_mindmend/src/features/home/presentation/viewmodels/info_viewmodel.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/info_views/widgets/intro_description.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/info_views/widgets/intro_heading.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/info_views/widgets/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Intro5 extends ConsumerWidget {
  final ChangeNotifierProvider<IntroViewModel> introViewModelProvider;

  const Intro5({super.key, required this.introViewModelProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final introViewModel = ref.watch(introViewModelProvider);
    return ListView(
      children: [
        const IntroHeading(heading: 'Image'),
        const IntroDescription(
            description:
                "To start off with imagine a scenario or situation that causes distress; you are not going to mentally view this-  play this in your mind like you are watching it back in third person- This method helps you put some space between yourself and the painful experience. as you are going through this - it could be images, thoughts, feelings, or sensations."),
        20.verticalSpace,
        const IntroDescription(
          isBullet: true,
          description:
              "As you are going through images and feeling in your head- how many moments did you feel? (mark this from 1-10 below)",
        ),
        20.verticalSpace,
        SliderWidget(
          sliderValue: introViewModel.imageValue,
          introViewModelProvider: introViewModelProvider,
          sliderNum: 1,
        ),
      ],
    );
  }
}
