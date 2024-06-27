import 'package:emdr_mindmend/src/core/commons/custom_button.dart';
import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/commons/loader.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/constants/images.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/views/drawer_screen.dart';
import 'package:emdr_mindmend/src/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final homeViewModelProvider = ChangeNotifierProvider<HomeViewModel>((ref) {
    return HomeViewModel();
  });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = ref.watch(homeViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      body: CustomLoader(
        isLoading: homeViewModel.isLoading,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: hMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                profileButton(),
                logo(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.sp),
                  child: const Divider(color: AppColors.borderColor),
                ),
                Text("Helping with pTSD and other\ntrauma-related conditions",
                    style: PoppinsStyles.bold.copyWith(fontSize: 18.sp)),
                10.verticalSpace,
                Text("Based on and emdr protocal",
                    style: PoppinsStyles.light.copyWith(fontSize: 14.sp)),
                infoWidget(
                  img: AppImages.startIcon,
                  title: 'Step by Step',
                  description: 'follow our guided process',
                ),
                infoWidget(
                  img: AppImages.audio,
                  title: 'Visual and auditory Stimulation\'s',
                  description:
                      'use the 2 most common stimulation\'s\n(visual and auditory) to aid your\ntreatment. You can skip to these if\ncomfortable to do so',
                ),
                const Spacer(),
                homeButtons(),
                30.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget infoWidget(
      {required String img,
      required String title,
      required String description}) {
    return Padding(
      padding: EdgeInsets.only(top: 30.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42.sp,
            height: 42.sp,
            decoration: const BoxDecoration(
                color: Color(0xffDEFAEE), shape: BoxShape.circle),
            child: Center(
              child: Image.asset(
                img,
                width: 16.sp,
                height: 16.sp,
                fit: BoxFit.contain,
              ),
            ),
          ),
          8.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: PoppinsStyles.semiBold.copyWith(fontSize: 16.sp)),
                8.verticalSpace,
                Text(description,
                    style: PoppinsStyles.light
                        .copyWith(fontSize: 12.sp, height: 1.2.sp)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget logo() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
          padding: EdgeInsets.only(top: 60.sp, bottom: 10.sp),
          child:
              Image.asset(AppImages.logo, height: 100.h, fit: BoxFit.contain)),
    );
  }

  Widget profileButton() {
    return Align(
      alignment: Alignment.topRight,
      child: CommonInkWell(
        onTap: () {
          CustomNavigation().push(const DrawerScreen());
        },
        child: Container(
          width: 40.sp,
          height: 40.sp,
          margin: EdgeInsets.only(top: 10.h),
          decoration: const BoxDecoration(
              color: AppColors.primaryColor, shape: BoxShape.circle),
          child: Center(
            child: Image.asset(
              AppImages.profile,
              width: 20.sp,
              height: 20.sp,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  Widget homeButtons() {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            title: 'Start',
            bgColor: AppColors.primaryColor,
            onPressed: () {
              _showAlertDialog();
            },
            icon: Image.asset(
              AppImages.startIcon,
              width: 16.sp,
              height: 16.sp,
              fit: BoxFit.contain,
              color: AppColors.whiteColor,
            ),
          ),
        ),
        15.horizontalSpace,
        Expanded(
          child: CustomButton(
            bgColor: AppColors.primaryColor,
            onPressed: () {},
            icon: Image.asset(
              AppImages.eye,
              width: 30.sp,
              height: 30.sp,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showAlertDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color(0xff1E1E1E).withOpacity(0.75),
            alignment: Alignment.center,
            title: Text(
              "Warning",
              textAlign: TextAlign.center,
              style: PoppinsStyles.semiBold
                  .copyWith(fontSize: 17.sp, color: AppColors.whiteColor),
            ),
            content: Text(
              "This application is not intended to substitute professional healthcare. We strongly advise that the initial use is conducted with the guidance of a trained psychologist. If you have any uncertainties, please consult a doctor or psychologist.",
              style: PoppinsStyles.light.copyWith(
                  fontSize: 13.sp, color: AppColors.whiteColor, height: 1.2.sp),
            ),
            actions: [
              Center(
                child: CommonInkWell(
                  onTap: () =>
                      CustomNavigation().pushReplacement(IntroScreen()),
                  child: Text("OK",
                      textAlign: TextAlign.center,
                      style: PoppinsStyles.semiBold.copyWith(
                          fontSize: 17.sp, color: AppColors.whiteColor)),
                ),
              )
            ],
          );
        });
  }
}
