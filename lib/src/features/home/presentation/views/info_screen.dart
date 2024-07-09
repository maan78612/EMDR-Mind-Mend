import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/commons/loader.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/enums/snackbar_status.dart';
import 'package:emdr_mindmend/src/core/utilities/custom_snack_bar.dart';
import 'package:emdr_mindmend/src/features/home/presentation/viewmodels/info_viewmodel.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/info_views/info_1.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/info_views/info_10.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/info_views/info_11.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/info_views/info_2.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/info_views/info_3.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/info_views/info_4.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/info_views/info_5.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/info_views/info_6.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/info_views/info_7.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/info_views/info_8.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/info_views/info_9.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoScreen extends ConsumerWidget {
  final bool isEye;

  InfoScreen({super.key, required this.isEye});

  final introViewModelProvider = ChangeNotifierProvider<IntroViewModel>((ref) {
    return IntroViewModel();
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final introViewModel = ref.watch(introViewModelProvider);
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      body: CustomLoader(
        isLoading: introViewModel.isLoading,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: hMargin),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: CommonInkWell(
                    onTap: () {
                      CustomNavigation().pop();
                    },
                    child: const Align(
                        alignment: Alignment.topRight,
                        child: Icon(Icons.close, color: AppColors.blackColor)),
                  ),
                ),
                10.verticalSpace,
                isEye
                    ? Expanded(
                        child: Intro8(
                            introViewModelProvider: introViewModelProvider))
                    : Expanded(
                        child: IndexedStack(
                          index: introViewModel.introIndex,
                          children: [
                            const Intro1(),
                            const Intro2(),
                            const Intro3(),
                            const Intro4(),
                            Intro5(
                                introViewModelProvider: introViewModelProvider),
                            Intro6(
                                introViewModelProvider: introViewModelProvider),
                            Intro7(
                                introViewModelProvider: introViewModelProvider),
                            Intro8(
                                introViewModelProvider: introViewModelProvider),
                            Intro9(
                                introViewModelProvider: introViewModelProvider),
                            Intro10(
                                introViewModelProvider: introViewModelProvider),
                            Intro11(
                                introViewModelProvider: introViewModelProvider),
                          ],
                        ),
                      ),
                if (!isEye)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonInkWell(
                        onTap: () => introViewModel.decrementIndex(),
                        child: Container(
                          width: 62.sp,
                          height: 62.sp,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.arrow_back,
                              color: AppColors.whiteColor, size: 24.sp),
                        ),
                      ),
                      CommonInkWell(
                        onTap: () {
                          bool isFinished =
                              introViewModel.incrementIndex(context);
                          if (isFinished) {
                            introViewModel.setScore(
                                showSnackBarMsg: ({
                              required SnackBarType snackType,
                              required String message,
                            }) =>
                                    Utils.showSnackBar(
                                        message, snackType, context));
                          }
                        },
                        child: Container(
                          width: 62.sp,
                          height: 62.sp,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.arrow_forward,
                              color: AppColors.whiteColor, size: 24.sp),
                        ),
                      )
                    ],
                  ),
                20.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}