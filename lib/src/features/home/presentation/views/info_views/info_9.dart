import 'package:emdr_mindmend/src/features/home/presentation/viewmodels/info_viewmodel.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/info_views/widgets/intro_description.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/info_views/widgets/intro_heading.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/info_views/widgets/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Intro9 extends ConsumerWidget {
  final ChangeNotifierProvider<IntroViewModel> introViewModelProvider;

  const Intro9({super.key, required this.introViewModelProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final introViewModel = ref.watch(introViewModelProvider);
    return ListView(
      children: [
        const IntroHeading(heading: 'Revaluation'),
        const IntroDescription(
            description:
                "Having gone through the desensitisation process- give it a few moments. "),
        30.verticalSpace,
        const IntroDescription(
            description:
                "Start off again with imagining the scenario or situation that caused you distress; "),
        30.verticalSpace,
        const IntroDescription(
            description:
                "How many moments did you feel? (mark this from 1-10 below)"),
        30.verticalSpace,
        SliderWidget(
          sliderValue: introViewModel.revaluationOne,
          introViewModelProvider: introViewModelProvider,
          sliderNum: 3,
        ),
      ],
    );
  }
}
