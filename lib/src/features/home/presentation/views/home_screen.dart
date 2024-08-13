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
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final homeViewModelProvider = ChangeNotifierProvider<HomeViewModel>((ref) {
    return HomeViewModel();
  });

  List<TargetFocus> targets = [];
  late TutorialCoachMark tutorialCoachMark;

  final GlobalKey profileButtonKey = GlobalKey();
  final GlobalKey startButtonKey = GlobalKey();
  final GlobalKey eyeButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeCoachMarks();
    });
  }

  void _initializeCoachMarks() {
    targets = [
      TargetFocus(
        identify: "profileButton",
        keyTarget: profileButtonKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: _showSettingDialog(),
          ),
        ],
      ),
      TargetFocus(
        identify: "startButton",
        keyTarget: startButtonKey,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: _startDialog(),
          ),
        ],
      ),
      TargetFocus(
        identify: "eyeButton",
        keyTarget: eyeButtonKey,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: _eyeDialog(),
          ),
        ],
      ),
    ];

    tutorialCoachMark = TutorialCoachMark(
      targets: targets,
      colorShadow: Colors.black,
      hideSkip: true,
      onFinish: () {
        // Handle finish
      },
    );

    tutorialCoachMark.show(context: context);
  }

  Widget _showSettingDialog() {
    return CustomAlertDialog(
      title: "Settings",
      description: "Change the sound, tone, colour and speed here",
      onTap: () {
        tutorialCoachMark.next(); // Show the next dialog
      },
      btnTitle: 'Next',
    );
  }

  Widget _startDialog() {
    return CustomAlertDialog(
      title: "Start",
      description: "Start the protocol here",
      onTap: () {
        tutorialCoachMark.next(); // Show the next dialog
      },
      btnTitle: 'Next',
    );
  }

  Widget _eyeDialog() {
    return CustomAlertDialog(
      title: "Stimulation",
      description: "Jump straight to audio / visual",
      onTap: () {
        tutorialCoachMark.finish(); // End the tutorial if no more steps
      },
      btnTitle: 'Done',
    );
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
                Text("Based on emdr protocol",
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

  Widget profileButton(HomeViewModel homeViewModel) {
    return CommonInkWell(
      key: profileButtonKey,
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
    );
  }

  Widget homeButtons() {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            key: startButtonKey,
            title: 'Start',
            bgColor: AppColors.primaryColor,
            onPressed: () {
              _showIntroDialog(true);
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
            key: eyeButtonKey,
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
              CustomNavigation().pushReplacement(InfoScreen(isEye: isEye)),
          btnTitle: 'OK',
        );
      },
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
}
