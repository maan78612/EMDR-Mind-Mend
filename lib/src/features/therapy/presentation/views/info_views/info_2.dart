import 'package:emdr_mindmend/src/features/therapy/presentation/views/widgets/info_description.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/widgets/info_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Info2 extends StatelessWidget {
  const Info2({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const infoHeading(heading: 'Disclaimer'),
      const InfoDescriptionWidget(isBullet: true, descriptions: [
        {'text': "Reflect on Your History: "},
        "Have you experienced other traumatic events in the past that still trigger intense emotions? If so, it may be best to consult with a health professional for additional support."
      ]),
      20.verticalSpace,
      const InfoDescriptionWidget(isBullet: true, descriptions: [
        {'text': "Consider Your Mental Health: "},
        "If you have a psychiatric history or have previously seen a mental health professional, seeking advice from an expert is advisable before proceeding with EMDR."
      ]),
      20.verticalSpace,
      const InfoDescriptionWidget(isBullet: true, descriptions: [
        {'text': "Identify Your Support System: "},
        "What resources do you currently have? Can you rely on family, friends, or a health professional for support? It's crucial to have external help, as mind",
        {'text': "mend"},
        " may elicit strong emotional reactions that require support."
      ]),
      20.verticalSpace,
      const InfoDescriptionWidget(isBullet: true, descriptions: [
        "Take a moment to consider these points. If you feel ready to address the challenging life events you’ve experienced, you can proceed with confidence."
      ]),
      20.verticalSpace,
      const InfoDescriptionWidget(
          isBullet: true,
          descriptions: ["Let's begin this journey towards healing together."]),
    ]);
  }
}
