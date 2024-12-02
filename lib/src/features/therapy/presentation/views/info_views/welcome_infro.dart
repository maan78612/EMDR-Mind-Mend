import 'package:emdr_mindmend/src/features/therapy/presentation/views/widgets/info_description.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/widgets/info_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeInfo extends StatelessWidget {
  const WelcomeInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const infoHeading(heading: 'Welcome'),
        20.verticalSpace,
        const InfoDescriptionWidget(
            descriptions: ["Start Your EMDR Journey With 3 Simple Steps"]),
        30.verticalSpace,
        const InfoDescriptionWidget(
          descriptions: [
            {'text': "1: Start The Guided Protocol Carefully:\n"},
            'Input How You Are Feeling So This Can Be Monitored. Stop At Any Time If You Feel Overwhelmed'
          ],
        ),
        30.verticalSpace,
        const InfoDescriptionWidget(
          descriptions: [
            {'text': "2: Use The Stimulation As Per Your Preference:\n"},
            'This Can Be Auditory Beats Or The Visual Stimulation'
          ],
        ),
        30.verticalSpace,
        const InfoDescriptionWidget(
          descriptions: [
            {'text': "3: Re-Evaluation: "},
            'Note Down On The App How You Feel After The Protocol To Monitor Your Progress'
          ],
        ),
        30.verticalSpace,
        const InfoDescriptionWidget(
            descriptions: ["Re-Do This As Many Times As Needed"]),
      ],
    );
  }
}
