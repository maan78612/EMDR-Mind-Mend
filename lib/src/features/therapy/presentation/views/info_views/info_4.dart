import 'package:emdr_mindmend/src/features/therapy/presentation/views/widgets/info_description.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/widgets/info_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Info4 extends StatelessWidget {
  const Info4({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const infoHeading(heading: 'How to follow the protocol'),
        const InfoDescriptionWidget(descriptions: [
          "What we will do initially is to have the thoughts that trigger off your symptoms; we will then desensitise this by eye movement or sound pulses. "
        ]),
        20.verticalSpace,
        const InfoDescriptionWidget(descriptions: [
          "Please feel free to stop at any time, and repeat the protocol as many times as required. we do recommend that this works best after having it done with a psychologist so that you can be guided by a professional. We will also be using a scoring system that wil help track your feelings whilst using it. "
        ]),
        20.verticalSpace,
      ],
    );
  }
}
