import 'package:emdr_mindmend/src/features/home/presentation/views/info_views/widgets/intro_description.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/info_views/widgets/intro_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Intro3 extends StatelessWidget {
  const Intro3({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const IntroHeading(heading: 'How it works'),
        const IntroDescription(

            description:"Old, upsetting memories can sometimes get stuck in our brains, locked away with the original images, sounds, thoughts, and feelings. These memories can keep getting triggered repeatedly, preventing us from learning and healing. Meanwhile, another part of our brain holds most of the information we need to resolve these issues, but the two parts can't connect."),20.verticalSpace,
        const IntroDescription(

            description:"That's where EMDR (Eye Movement Desensitisation and Reprocessing) comes in. Once EMDR begins, it helps to link these parts of the brain. New information can emerge, allowing you to resolve old problems. This process is similar to what might happen naturally during REM sleep or dreams, where eye movements help process unconscious material."),20.verticalSpace,

      ],
    );
  }
}
