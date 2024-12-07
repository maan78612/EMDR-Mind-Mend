import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/enums/color_enum.dart';
import 'package:emdr_mindmend/src/core/manager/color_manager.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/viewmodels/therapy_viewmodel.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/widgets/info_description.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/widgets/info_heading.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/widgets/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Info6 extends ConsumerWidget {
  final ChangeNotifierProvider<TherapyViewModel> therapyViewModelProvider;

  const Info6({super.key, required this.therapyViewModelProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final therapyViewModel = ref.watch(therapyViewModelProvider);
    final colorMode = ref.watch(colorModeProvider);
    return ListView(
      children: [
        const infoHeading(heading: 'General emotion'),
        const InfoDescriptionWidget(
          isBullet: true,
          descriptions: [
            "As you are going through images and feeling in your head- how many moments did you feel? (mark this from 1-10 below)"
          ],
        ),
        30.verticalSpace,
        SliderWidget(
          sliderValue: therapyViewModel.generalEmotion,
          therapyViewModelProvider: therapyViewModelProvider,
          sliderNum: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "(no disturbance/neutral)",
              style: PoppinsStyles.light(
                      color: AppColorHelper.getTertiaryTextColor(colorMode))
                  .copyWith(fontSize: 10.sp),
            ),
            Text(
              "(highest disturbance)",
              style: PoppinsStyles.light(
                      color: AppColorHelper.getTertiaryTextColor(colorMode))
                  .copyWith(fontSize: 10.sp),
            )
          ],
        ),
        30.verticalSpace,
        const InfoDescriptionWidget(
          descriptions: [
            "As you bring up those thoughts and feelings- what emotions do you feel?"
          ],
        ),
        30.verticalSpace,
        Column(
          children: List.generate(
            therapyViewModel.emotionList.length ~/ 2,
            (index) {
              List<Map<int, String>> data = [
                therapyViewModel.emotionList[index * 2],
                if (index * 2 + 1 < therapyViewModel.emotionList.length)
                  therapyViewModel.emotionList[index * 2 + 1]
              ];
              return Container(
                margin: EdgeInsets.only(bottom: 10.sp),
                decoration: BoxDecoration(
                  color: const Color(0xfff1f1f3),
                  borderRadius: BorderRadius.all(Radius.circular(20.r)),
                ),
                child: Row(
                  children: List.generate(data.length, (index) {
                    return settingOptionWidget(
                        emotionData: data[index],
                        therapyViewModel: therapyViewModel,
                        colorMode: colorMode);
                  }),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget settingOptionWidget(
      {required Map<int, String> emotionData,
      required TherapyViewModel therapyViewModel,
      required ColorMode colorMode}) {
    return Expanded(
      child: CommonInkWell(
        onTap: () {
          therapyViewModel.toggleEmotion(emotionData.keys.first);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 6.sp),
          margin: EdgeInsets.all(4.sp),
          decoration:
              therapyViewModel.addedEmotions.contains(emotionData.keys.first)
                  ? BoxDecoration(
                      color: AppColorHelper.getScaffoldColor(colorMode),
                      borderRadius: BorderRadius.all(Radius.circular(30.r)))
                  : const BoxDecoration(),
          child: Text(
            emotionData.values.first,
            textAlign: TextAlign.center,
            style:
                therapyViewModel.addedEmotions.contains(emotionData.keys.first)
                    ? PoppinsStyles.semiBold(color: AppColors.primaryColor)
                        .copyWith(
                        fontSize: 14.sp,
                      )
                    : PoppinsStyles.regular(color: AppColors.greyColor)
                        .copyWith(fontSize: 14.sp),
          ),
        ),
      ),
    );
  }
}
