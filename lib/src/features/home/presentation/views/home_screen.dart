import 'package:emdr_mindmend/src/core/commons/custom_button.dart';
import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/commons/dialog_widget.dart';
import 'package:emdr_mindmend/src/core/commons/loader.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/constants/images.dart';
import 'package:emdr_mindmend/src/core/enums/color_enum.dart';
import 'package:emdr_mindmend/src/core/manager/color_manager.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/views/drawer_screen.dart';
import 'package:emdr_mindmend/src/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/therapy_screen.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final homeViewModel = ref.read(homeViewModelProvider);
      await homeViewModel.initMethod(context, ref.read(userModelProvider));
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = ref.watch(homeViewModelProvider);
    final colorMode = ref.watch(colorModeProvider);
    return Scaffold(
      backgroundColor: AppColorHelper.getScaffoldColor(colorMode),
      body: CustomLoader(
        isLoading: homeViewModel.isLoading,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: hMargin),
            child: Stack(
              children: [
                Column(
                  children: [
                    20.verticalSpace,
                    logo(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.sp),
                      child:  Divider(
                          color: AppColorHelper.dividerColor(colorMode)),
                    ),
                    Text(
                        "Helping with PTSD and other\ntrauma-related conditions",
                        style: PoppinsStyles.bold(
                                color: AppColorHelper.getPrimaryTextColor(
                                    colorMode))
                            .copyWith(fontSize: 18.sp)),
                    10.verticalSpace,
                    Text("Based on emdr protocol",
                        style: PoppinsStyles.light(
                                color: AppColorHelper.getPrimaryTextColor(
                                    colorMode))
                            .copyWith(fontSize: 14.sp)),
                    infoWidget(
                      img: AppImages.startIcon,
                      colorMode: colorMode,
                      title: 'Step by Step',
                      description: 'follow our guided process',
                    ),
                    infoWidget(
                      img: AppImages.audio,
                      colorMode: colorMode,
                      title: 'Visual and auditory Stimulation\'s',
                      description:
                          'use the 2 most common stimulation\'s\n(visual and auditory) to aid your\ntreatment. You can skip to these if\ncomfortable to do so',
                    ),
                    60.verticalSpace,
                    homeButtons(homeViewModel),
                    30.verticalSpace,
                  ],
                ),
                profileButton(homeViewModel),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profileButton(HomeViewModel homeViewModel) {
    return Positioned(
      key: homeViewModel.profileButtonKey,
      right: 0,
      child: CommonInkWell(
        onTap: () {
          CustomNavigation().push(const DrawerScreen());
        },
        child: Container(
          width: 40.sp,
          height: 40.sp,
          margin: EdgeInsets.all(10.sp),
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

  Widget homeButtons(HomeViewModel homeViewModel) {
    return Row(
      children: [
        Expanded(
          key: homeViewModel.startButtonKey,
          child: CustomButton(
            title: 'Start',
            bgColor: AppColors.primaryColor,
            onPressed: () {
              /// TODO : temporarily comment subscription part
              /* ----------------------------------------------
            if (homeViewModel.subscriptionStatus()) {
                _showIntroDialog(false);
              } else {
                  CustomNavigation().push(SubscriptionScreen(
                    homeViewModelProvider: homeViewModelProvider,
                    ));
              }
            --------------------------------------------- */
              _showIntroDialog(false);
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
          key: homeViewModel.eyeButtonKey,
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

  Future<void> _showIntroDialog(bool isEye) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: "Warning",
          description:
              "This application is not intended to substitute professional healthcare. We strongly advise that the initial use is conducted with the guidance of a trained psychologist. If you have any uncertainties, please consult a doctor or psychologist.",
          onTap: () =>
              CustomNavigation().pushReplacement(TherapyScreen(isShort: isEye)),
          btnTitle: 'OK',
        );
      },
    );
  }

  Widget infoWidget(
      {required String img,
      required String title,
      required String description,
      required ColorMode colorMode}) {
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
                    style: PoppinsStyles.semiBold(
                            color:
                                AppColorHelper.getPrimaryTextColor(colorMode))
                        .copyWith(fontSize: 16.sp)),
                8.verticalSpace,
                Text(description,
                    style: PoppinsStyles.light(
                            color:
                                AppColorHelper.getPrimaryTextColor(colorMode))
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
}
