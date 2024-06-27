import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/features/home/presentation/viewmodels/intro_viewmodel.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/intro_views/widgets/intro_description.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/intro_views/widgets/intro_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Intro7 extends ConsumerWidget {
  final ChangeNotifierProvider<IntroViewModel> introViewModelProvider;

  const Intro7({super.key, required this.introViewModelProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final introViewModel = ref.watch(introViewModelProvider);
    return ListView(
      children: [
        const IntroHeading(heading: 'General emotion'),
        const IntroDescription(
          description:
              "As you bring up those thoughts and feelings- what emotions do you feel?",
        ),
        30.verticalSpace,
        Column(
          children: List.generate(
            introViewModel.emotionList.length ~/ 2,
            (index) {
              List<String> data = [
                introViewModel.emotionList[index * 2],
                if (index * 2 + 1 < introViewModel.emotionList.length)
                  introViewModel.emotionList[index * 2 + 1]
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
                      title: data[index],
                      introViewModel: introViewModel,
                    );
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
      {required String title, required IntroViewModel introViewModel}) {
    return Expanded(
      child: CommonInkWell(
        onTap: () {
          introViewModel.addEmotion(title);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 6.sp),
          margin: EdgeInsets.all(4.sp),
          decoration: introViewModel.addedEmotions.contains(title)
              ? BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(30.r)))
              : const BoxDecoration(),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: introViewModel.addedEmotions.contains(title)
                ? PoppinsStyles.semiBold
                    .copyWith(fontSize: 14.sp, color: AppColors.primaryColor)
                : PoppinsStyles.regular
                    .copyWith(fontSize: 14.sp, color: AppColors.greyColor),
          ),
        ),
      ),
    );
  }
}
