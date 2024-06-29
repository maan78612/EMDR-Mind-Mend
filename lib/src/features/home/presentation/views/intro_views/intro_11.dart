
import 'package:emdr_mindmend/src/features/home/presentation/viewmodels/intro_viewmodel.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/intro_views/widgets/intro_description.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/intro_views/widgets/intro_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Intro11 extends ConsumerWidget {
  final ChangeNotifierProvider<IntroViewModel> introViewModelProvider;

  const Intro11({super.key, required this.introViewModelProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final introViewModel = ref.watch(introViewModelProvider);
    return ListView(
      children: [
        const IntroHeading(heading: 'End'),
        const IntroDescription(
            description: "According to the information you have given; "),
        30.verticalSpace,
        const IntroDescription(
          description:
              "Your distress level before desensitisation therapy was ",
          boldDescriptionEnd: "7/10",
        ),
        30.verticalSpace,
        const IntroDescription(
          description:
              "Your distress level after desensitisation therapy was ",
          boldDescriptionEnd: "2/10",
        ),
        60.verticalSpace,
        const IntroDescription(
            description: "This App has been developed for you to use as required until any disturbance is gone or reduced. "),
      ],
    );
  }
}
