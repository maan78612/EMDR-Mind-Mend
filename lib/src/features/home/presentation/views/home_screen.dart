import 'dart:ui';

import 'package:emdr_mindmend/src/core/commons/custom_button.dart';
import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/commons/dialog_widget.dart';
import 'package:emdr_mindmend/src/core/commons/loader.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/constants/images.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/views/drawer_screen.dart';
import 'package:emdr_mindmend/src/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:emdr_mindmend/src/features/home/presentation/views/info_screen.dart';
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
    ///TODO: temporarily disable subscription part
    /* WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(homeViewModelProvider).getSubscriptionList(
              showSnackBarMsg: ({
            required SnackBarType snackType,
            required String message,
          }) =>
                  Utils.showSnackBar(message, snackType,
                      CustomNavigation().navigatorKey.currentState!.context));
      if (!subscriptionStatus()) {
        subscriptionNavigation();
      }
    });*/
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
            child: ListView(
              children: [
                profileButton(homeViewModel),
                logo(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.sp),
                  child: const Divider(color: AppColors.borderColor),
                ),
                Text("Helping with PTSD and other\ntrauma-related conditions",
                    style: PoppinsStyles.bold.copyWith(fontSize: 18.sp)),
                10.verticalSpace,
                Text("Based on  emdr protocol",
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
                60.verticalSpace,
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

  Widget profileButton(HomeViewModel homeViewModel) {
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
              /// when subscription feature enable remove _showAlertDialog(false);
              _showIntroDialog(false);

              ///TODO: temporarily disable subscription part
              /*  if (subscriptionStatus()) {
                _showAlertDialog(false);
              } else {
                subscriptionNavigation();
              }*/
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
            onPressed: () {
              _showIntroDialog(true);
            },
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

  ///TODO: temporarily disable subscription part
  // subscriptionNavigation() {
  //   CustomNavigation().push(SubscriptionScreen(
  //     homeViewModelProvider: homeViewModelProvider,
  //
  //   ));
  // }

  Future<void> _showIntroDialog(bool isEye) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: "Warning",
          description:
              "This application is not intended to substitute professional healthcare. We strongly advise that the initial use is conducted with the guidance of a trained psychologist. If you have any uncertainties, please consult a doctor or psychologist.",
          onTap: () =>
              CustomNavigation().pushReplacement(InfoScreen(isEye: isEye)),
          btnTitle: 'OK',
        );
      },
    );
  }

  Widget _showSettingDialog() {
    return CustomAlertDialog(
      title: "Settings",
      description: "Change the sound, tone, colour and speed here",
      onTap: () {},
      btnTitle: 'Next',
    );
  }

  Widget _startDialog() {
    return CustomAlertDialog(
      title: "Start",
      description: "Start the protocol here",
      onTap: () {},
      btnTitle: 'Next',
    );
  }

  Widget _eyeDialog() {
    return CustomAlertDialog(
      title: "Stimulation",
      description: "Jump straight to audio / visual",
      onTap: () {},
      btnTitle: 'Next',
    );
  }
}
