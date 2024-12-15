
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/viewmodels/therapy_viewmodel.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/widgets/info_description.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/widgets/info_heading.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/widgets/info_title.dart';

class Info1 extends StatelessWidget {
  final ChangeNotifierProvider<TherapyViewModel> therapyViewModelProvider;



  // final String videoUrl = 'https://www.youtube.com/watch?v=vLmlcLLdkoA';

  const Info1({super.key,required this.therapyViewModelProvider});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 280.h,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(12.r))),
          width: double.infinity,
          child: CustomVideoPlayer(therapyViewModelProvider: therapyViewModelProvider,),
        ),
        20.verticalSpace,
        const infoHeading(heading: 'Intro'),
        const InfoDescriptionWidget(
          descriptions: [
            'Welcome to your journey towards recovery with mind',
            {'text': "mend"},
            '. Many have overcome their traumatic life experiences using EMDR, and we\'re here to support you every step of the way. This app is designed to help you navigate your emotional challenges, but it\'s important to be well-prepared before you start.'
          ],
        ),
        40.verticalSpace,
        const InfoTitle(title: "Purpose of the App"),
        const InfoDescriptionWidget(isBullet: true, descriptions: [
          "Our app aims to prevent the long-term suffering that can follow a traumatic event. By reducing the intense emotions linked to painful memories, it helps desensitise you to these traumas. This process, known as desensitisation, is achieved through bilateral alternating stimulation."
        ]),
        40.verticalSpace,
        const InfoTitle(title: "EMDR Therapy"),
        const InfoDescriptionWidget(isBullet: true, descriptions: [
          "This app is based on EMDR (Eye Movement Desensitization and Reprocessing), a highly recommended therapy for managing psychological trauma. EMDR has proven effective in helping many individuals overcome their distress, and mind",
          {'text': "mend"},
          " brings this therapeutic approach to you in a convenient and accessible format."
        ])
      ],
    );
  }
}
