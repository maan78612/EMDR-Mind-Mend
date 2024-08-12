import 'package:emdr_mindmend/src/features/home/presentation/views/info_views/widgets/intro_description.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/info_views/widgets/intro_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeIntro extends StatelessWidget {
  const WelcomeIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const IntroHeading(heading: 'Welcome'),
        20.verticalSpace,
        const UpdatedIntroDescription(
            descriptions: ["Start Your EMDR Journey With 3 Simple Steps"]),
        30.verticalSpace,
        const UpdatedIntroDescription(
          descriptions: [
            {'text': "1: Start The Guided Protocol Carefully:\n"},
            'Input How You Are Feeling So This Can Be Monitored. Stop At Any Time If You Feel Overwhelmed'
          ],
        ),
        30.verticalSpace,
        const UpdatedIntroDescription(
          descriptions: [
            {'text': "2: Use The Stimulation As Per Your Preference:\n"},
            'This Can Be Auditory Beats Or The Visual Stimulation'
          ],
        ),
        30.verticalSpace,
        const UpdatedIntroDescription(
          descriptions: [
            {'text': "3: Re-Evaluation: "},
            'Note Down On The App How You Feel After The Protocol To Monitor Your Progress'
          ],
        ),
        30.verticalSpace,
        const UpdatedIntroDescription(
            descriptions: ["Re-Do This As Many Times As Needed"]),
      ],
    );
  }
}
