import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/viewmodels/therapy_viewmodel.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/widgets/info_description.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/widgets/info_heading.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/widgets/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Info9 extends ConsumerWidget {
  final ChangeNotifierProvider<TherapyViewModel> therapyViewModelProvider;

  const Info9({super.key, required this.therapyViewModelProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final therapyViewModel = ref.watch(therapyViewModelProvider);
    return ListView(
      children: [
        const infoHeading(heading: 'Revaluation'),
        const InfoDescriptionWidget(descriptions: [
          "Having gone through the desensitisation process- give it a few moments. "
        ]),
        20.verticalSpace,
        const InfoDescriptionWidget(descriptions: [
          "Start off again with imagining the scenario or situation that caused you distress; "
        ]),
        20.verticalSpace,
        const InfoDescriptionWidget(descriptions: [
          "How many moments did you feel? (mark this from 1-10 below)"
        ]),
        20.verticalSpace,
        SliderWidget(
          sliderValue: therapyViewModel.revaluationOne,
          therapyViewModelProvider: therapyViewModelProvider,
          sliderNum: 3,
        ),
        60.verticalSpace,
        const InfoDescriptionWidget(
          isBullet: true,
          descriptions: [
            "As you bring up those thoughts and feelings- how disturbing does it feel to you?"
          ],
        ),
        20.verticalSpace,
        SliderWidget(
          sliderValue: therapyViewModel.revaluationTwo,
          therapyViewModelProvider: therapyViewModelProvider,
          sliderNum: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "(no disturbance/neutral)",
              style: PoppinsStyles.light
                  .copyWith(fontSize: 10.sp, color: const Color(0xff424242)),
            ),
            Text(
              "(highest disturbance)",
              style: PoppinsStyles.light
                  .copyWith(fontSize: 10.sp, color: const Color(0xff424242)),
            )
          ],
        )
      ],
    );
  }
}
