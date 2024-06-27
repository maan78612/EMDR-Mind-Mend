import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/features/home/presentation/viewmodels/intro_viewmodel.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/intro_views/intro_1.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/intro_views/intro_2.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/intro_views/intro_3.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/intro_views/intro_4.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/intro_views/intro_5.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/intro_views/intro_6.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/intro_views/intro_7.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/intro_views/intro_8.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/intro_views/intro_9.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroScreen extends ConsumerWidget {
  IntroScreen({super.key});

  final introViewModelProvider = ChangeNotifierProvider<IntroViewModel>((ref) {
    return IntroViewModel();
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final introViewModel = ref.watch(introViewModelProvider);
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: hMargin),
          child: Column(
            children: [
              10.verticalSpace,
              Expanded(
                child: IndexedStack(
                  index: introViewModel.introIndex,
                  children: [
                    const Intro1(),
                    const Intro2(),
                    const Intro3(),
                    const Intro4(),
                    Intro5(introViewModelProvider: introViewModelProvider),
                    Intro6(introViewModelProvider: introViewModelProvider),
                    Intro7(introViewModelProvider: introViewModelProvider),
                    Intro8(introViewModelProvider: introViewModelProvider),
                    const Intro9(),
                  ],
                ),
              ),
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
                    onTap: () => introViewModel.incrementIndex(),
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
            ],
          ),
        ),
      ),
    );
  }
}
