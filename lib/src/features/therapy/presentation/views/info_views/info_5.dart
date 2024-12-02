
import 'package:emdr_mindmend/src/features/therapy/presentation/viewmodels/therapy_viewmodel.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/widgets/info_description.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/widgets/info_heading.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/widgets/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Info5 extends ConsumerWidget {
  final ChangeNotifierProvider<TherapyViewModel> therapyViewModelProvider;

  const Info5({super.key, required this.therapyViewModelProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final therapyViewModel = ref.watch(therapyViewModelProvider);
    return ListView(
      children: [
        const infoHeading(heading: 'Image'),
        const InfoDescriptionWidget(descriptions: [
          "To start off with, imagine a scenario or situation that causes distress; you are not going to mentally view this-  play this in your mind like you are watching it back in third person- This method helps you put some space between yourself and the painful experience. as you are going through this - it could be images, thoughts, feelings, or sensations."
        ]),
        20.verticalSpace,
        const InfoDescriptionWidget(
          isBullet: true,
          descriptions: [
            "As you are going through images and feeling in your head- how many moments did you feel? (mark this from 1-10 below)"
          ],
        ),
        20.verticalSpace,
        SliderWidget(
          sliderValue: therapyViewModel.imageValue,
          therapyViewModelProvider: therapyViewModelProvider,
          sliderNum: 1,
        ),
      ],
    );
  }
}
