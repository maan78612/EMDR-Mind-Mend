import 'package:emdr_mindmend/src/features/home/presentation/views/intro_views/widgets/intro_description.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/intro_views/widgets/intro_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Intro2 extends StatelessWidget {
  const Intro2({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const IntroHeading(heading: 'Disclaimer'),
        const IntroDescription(
            isBullet: true,
            boldDescription: "Reflect on Your History: ",
            description:
                "Have you experienced other traumatic events in the past that still trigger intense emotions? If so, it may be best to consult with a health professional for additional support."),
        20.verticalSpace,
        const IntroDescription(
            isBullet: true,
            boldDescription: "Consider Your Mental Health:",
            description:
                "If you have a psychiatric history or have previously seen a mental health professional, seeking advice from an expert is advisable before proceeding with EMDR"),
        20.verticalSpace,
        const IntroDescription(
            isBullet: true,
            boldDescription: "Identify Your Support System: ",
            description:
                "What resources do you currently have? Can you rely on family, friends, or a health professional for support? It's crucial to have external help, as MindMend may elicit strong emotional reactions that require support."),
        20.verticalSpace,
        const IntroDescription(
            isBullet: true,
            description:
                "Take a moment to consider these points. If you feel ready to address the challenging life events you’ve experienced, you can proceed with confidence"),
        20.verticalSpace,
        const IntroDescription(
            isBullet: true,
            description: "Let's begin this journey towards healing together."),
      ],
    );
  }
}
