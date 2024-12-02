import 'package:emdr_mindmend/src/features/therapy/presentation/views/info_views/welcome_infro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/commons/loader.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/utilities/custom_snack_bar.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/viewmodels/therapy_viewmodel.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/info_views/info_1.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/info_views/info_2.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/info_views/info_3.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/info_views/info_4.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/info_views/info_5.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/info_views/info_6.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/info_views/info_8.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/info_views/info_9.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/info_views/info_11.dart';

class TherapyScreen extends ConsumerWidget {
  final bool isEye;

  TherapyScreen({super.key, required this.isEye});

  final therapyViewModelProvider =
      ChangeNotifierProvider<TherapyViewModel>((ref) {
    return TherapyViewModel();
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final therapyViewModel = ref.watch(therapyViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      body: CustomLoader(
        isLoading: therapyViewModel.isLoading,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: hMargin),
            child: Column(
              children: [
                // Close button
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: CommonInkWell(
                    onTap: () {
                      CustomNavigation().pop();
                    },
                    child: const Align(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.close, color: AppColors.blackColor),
                    ),
                  ),
                ),
                10.verticalSpace,
                // Main content
                Expanded(
                  child: isEye
                      ? IndexedStack(
                          index: therapyViewModel.introIndex,
                          children: [
                            Info6(
                                therapyViewModelProvider:
                                    therapyViewModelProvider),
                            Info8(
                                therapyViewModelProvider:
                                    therapyViewModelProvider),
                            Info9(
                                therapyViewModelProvider:
                                    therapyViewModelProvider),
                            Info11(
                                therapyViewModelProvider:
                                    therapyViewModelProvider),
                          ],
                        )
                      : IndexedStack(
                          index: therapyViewModel.introIndex,
                          children: [
                            const WelcomeInfo(),
                            const Info1(),
                            const Info2(),
                            const Info3(),
                            const Info4(),
                            Info5(
                                therapyViewModelProvider:
                                    therapyViewModelProvider),
                            Info6(
                                therapyViewModelProvider:
                                    therapyViewModelProvider),
                            Info8(
                                therapyViewModelProvider:
                                    therapyViewModelProvider),
                            Info9(
                                therapyViewModelProvider:
                                    therapyViewModelProvider),
                            Info11(
                                therapyViewModelProvider:
                                    therapyViewModelProvider),
                          ],
                        ),
                ),
                // Navigation controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button
                    CommonInkWell(
                      onTap: therapyViewModel.decrementIndex,
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
                    // Dots indicator
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(isEye ? 4 : 12, (index) {
                        return Container(
                          width: 10.sp,
                          height: therapyViewModel.introIndex == index
                              ? 14.sp
                              : 4.sp,
                          margin: EdgeInsets.only(right: 4.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(56.sp),
                            color: AppColors.primaryColor.withOpacity(
                                therapyViewModel.introIndex == index ? 1 : 0.4),
                          ),
                        );
                      }),
                    ),
                    // Forward button
                    CommonInkWell(
                      onTap: () {
                        if (therapyViewModel.incrementIndex(isEye)) {
                          therapyViewModel.setScore(
                            showSnackBarMsg: ({
                              required snackType,
                              required message,
                            }) {
                              SnackBarUtils.show(message, snackType);
                            },
                          );
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
                    ),
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
