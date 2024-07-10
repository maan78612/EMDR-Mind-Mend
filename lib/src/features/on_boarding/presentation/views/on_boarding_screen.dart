import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/features/auth/presentation/views/login_screen.dart';
import 'package:emdr_mindmend/src/features/on_boarding/domain/models/on_boarding.dart';
import 'package:emdr_mindmend/src/features/on_boarding/presentation/viewmodels/on_boarding_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingScreen extends ConsumerStatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  ConsumerState<OnBoardingScreen> createState() => _OnBoardingScreen();
}

class _OnBoardingScreen extends ConsumerState<OnBoardingScreen> {
  final onBoardingViewModelProvider =
      ChangeNotifierProvider<OnBoardingViewModel>((ref) {
    return OnBoardingViewModel();
  });

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(onBoardingViewModelProvider).init();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final onBoardingViewModel = ref.watch(onBoardingViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: hMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CommonInkWell(
                onTap: () => CustomNavigation().pushReplacement(LoginScreen()),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 10.sp, top: 10.sp, bottom: 10.sp),
                  child: Text(
                    "skip",
                    style: PoppinsStyles.regular.copyWith(fontSize: 14.sp),
                  ),
                ),
              ),
              Expanded(
                child: IndexedStack(
                  index: onBoardingViewModel.currentIndex,
                  children: List.generate(
                      onBoardingViewModel.onBoarding.length,
                      (index) => onBoardingWidget(
                          onBoardingViewModel.onBoarding[index], index)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                        onBoardingViewModel.onBoarding.length, (index) {
                      return Container(
                        width: onBoardingViewModel.currentIndex == index
                            ? 5.sp
                            : 7,
                        height: onBoardingViewModel.currentIndex == index
                            ? 20.sp
                            : 7.sp,
                        margin: EdgeInsets.only(right: 4.sp),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(56.sp)),
                          color: AppColors.primaryColor.withOpacity(
                              onBoardingViewModel.currentIndex == index
                                  ? 1
                                  : 0.4),
                        ),
                      );
                    }),
                  ),
                  CommonInkWell(
                    onTap: () => onBoardingViewModel.setIndex(),
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
    );
  }

  Widget onBoardingWidget(OnBoardingModel onBoarding, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(onBoarding.img,
            height: onBoarding.imgHeight, fit: BoxFit.fitHeight),
        30.verticalSpace,
        RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              children: [
                TextSpan(
                  text: onBoarding.title,
                  style: PoppinsStyles.bold.copyWith(fontSize: 24.sp),
                ),
                if (index == 0) ...[
                  TextSpan(
                    text: " mind",
                    style: PoppinsStyles.regular.copyWith(fontSize: 24.sp),
                  ),
                  TextSpan(
                    text: " mind",
                    style: PoppinsStyles.bold.copyWith(fontSize: 24.sp),
                  ),
                ]
              ],
            )),
        30.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.sp),
          child: Text(
            onBoarding.description,
            textAlign: TextAlign.center,
            style: PoppinsStyles.regular.copyWith(
                fontSize: 14.sp,
                color: const Color(0xff999999),
                height: 1.2.sp),
          ),
        ),
      ],
    );
  }
}
