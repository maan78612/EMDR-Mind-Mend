import 'package:emdr_mindmend/src/features/therapy/presentation/viewmodels/therapy_viewmodel.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/widgets/info_description.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/widgets/info_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Info11 extends ConsumerWidget {
  final ChangeNotifierProvider<TherapyViewModel> therapyViewModelProvider;

  const Info11({super.key, required this.therapyViewModelProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final therapyViewModel = ref.watch(therapyViewModelProvider);
    return ListView(
      children: [
        const infoHeading(heading: 'End'),
        const InfoDescriptionWidget(
            descriptions: ["According to the information you have given; "]),
        30.verticalSpace,
        InfoDescriptionWidget(
          descriptions: [
            "Your distress level before desensitisation therapy was ",
            {'text': '${therapyViewModel.generalEmotion.toInt()}/10'},
          ],
        ),
        30.verticalSpace,
        InfoDescriptionWidget(descriptions: [
          "Your distress level after desensitisation therapy was ",
          {'text': '${therapyViewModel.revaluationOne.toInt()}/10'},
        ]),
        60.verticalSpace,
        const InfoDescriptionWidget(descriptions: [
          "This App has been developed for you to use as required until any disturbance is gone or reduced. "
        ]),
      ],
    );
  }
}
