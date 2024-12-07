import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/enums/color_ball.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PendulumAnimation extends ConsumerStatefulWidget {
  const PendulumAnimation({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PendulumAnimationState();
}

class _PendulumAnimationState extends ConsumerState<PendulumAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller = AnimationController(
        vsync: this,
        duration: Duration(
            milliseconds:
                5000 ~/ (ref.read(settingViewModelProvider).visualSpeed * 3)),
      )..repeat(reverse: true);
      _animation = Tween<double>(begin: -1, end: 1).animate(_controller);

      ref.read(settingViewModelProvider).initAnimation(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final settingViewModel = ref.watch(settingViewModelProvider);

    return Scaffold(
      backgroundColor: settingViewModel.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        leading: CommonInkWell(
          onTap: () {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
            ]);
            ref.read(settingViewModelProvider).initAnimation(false);
            CustomNavigation().pop();
          },
          child: Icon(Icons.arrow_back_ios,
              color: settingViewModel.bgColor == AppColors.lightPrimaryTextColor
                  ? AppColors.whiteColor
                  : AppColors.lightPrimaryTextColor),
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Center(
            child: settingViewModel.isAnimationInitialize
                ? AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(
                          MediaQuery.of(context).size.width /
                              2.3 *
                              _animation.value,
                          0,
                        ),
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: settingViewModel
                                .getColor(settingViewModel.ballColor),
                            border: Border.all(
                                color: settingViewModel.ballColor ==
                                        BallColor.black
                                    ? AppColors.whiteColor
                                    : settingViewModel
                                        .getColor(settingViewModel.ballColor)),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: settingViewModel.ballColor ==
                                        BallColor.black
                                    ? AppColors.whiteColor
                                    : settingViewModel
                                        .getColor(settingViewModel.ballColor)
                                        .withOpacity(0.4),
                                blurRadius: 10,
                                spreadRadius: 2,
                                blurStyle: BlurStyle.normal,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : const CircularProgressIndicator(),
          ),
          if ((MediaQuery.of(context).orientation) == Orientation.portrait)
            Container(
              width: 250.w,
              margin: EdgeInsets.only(top: 10.h),
              padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 16.sp),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.redColor, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10.r))),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.screen_lock_landscape_sharp,
                    color: AppColors.redColor,
                    size: 24.sp,
                  ),
                  7.horizontalSpace,
                  Expanded(
                      child: Text(
                    "Please turn the device to landscape mode",
                    style: PoppinsStyles.bold(color: AppColors.redColor,)
                        .copyWith( fontSize: 16.sp),
                  ))
                ],
              ),
            ),
        ],
      ),
    );
  }
}
