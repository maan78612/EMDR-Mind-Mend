import 'package:emdr_mindmend/src/core/commons/custom_button.dart';
import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/commons/custom_input_field.dart';
import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/commons/loader.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/constants/images.dart';
import 'package:emdr_mindmend/src/core/constants/text_field_validator.dart';
import 'package:emdr_mindmend/src/core/enums/color_enum.dart';
import 'package:emdr_mindmend/src/core/manager/color_manager.dart';
import 'package:emdr_mindmend/src/features/auth/presentation/viewmodels/forget_pass_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordScreen extends ConsumerWidget {
  final forgetPassViewModelProvider =
      ChangeNotifierProvider<ForgetPassViewModel>((ref) {
    return ForgetPassViewModel();
  });

  ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forgetPassViewModel = ref.watch(forgetPassViewModelProvider);
    final colorMode = ref.watch(colorModeProvider);
    return Scaffold(
      backgroundColor: AppColorHelper.getScaffoldColor(colorMode),
      resizeToAvoidBottomInset: true,
      body: CustomLoader(
        isLoading: forgetPassViewModel.isLoading,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: hMargin),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  closeIcon(colorMode),
                  Image.asset(
                    AppImages.logo,
                    width: 100.sp,
                  ),
                  30.verticalSpace,
                  Text(
                    "Forget Password!",
                    style: PoppinsStyles.bold(
                            color: colorMode == ColorMode.light
                                ? AppColors.lightPrimaryTextColor
                                : AppColors.darkPrimaryTextColor)
                        .copyWith(fontSize: 22.sp),
                  ),
                  10.verticalSpace,
                  Text(
                    "Please enter your email to get reset link",
                    style: PoppinsStyles.regular(
                            color:
                                AppColorHelper.getTertiaryTextColor(colorMode))
                        .copyWith(fontSize: 14.sp),
                  ),
                  35.verticalSpace,
                  CustomInputField(
                    prefixWidget: Image.asset(AppImages.email),
                    hint: "Email",
                    textInputAction: TextInputAction.next,
                    controller: forgetPassViewModel.emailCon,
                    onChange: (value) {
                      forgetPassViewModel.onChange(
                          con: forgetPassViewModel.emailCon,
                          value: value,
                          validator: TextFieldValidator.validateEmail);
                    },
                    colorMode: colorMode,
                  ),
                  CustomButton(
                    title: 'Submit',
                    isEnable: forgetPassViewModel.isBtnEnable,
                    bgColor: AppColors.primaryColor,
                    onPressed: () {
                      forgetPassViewModel.forgetPass(context);
                    },
                  ),
                  40.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget closeIcon(ColorMode colorMode) {
    return Padding(
      padding: EdgeInsets.only(top: 30.h, bottom: 50.h),
      child: CommonInkWell(
        onTap: () {
          CustomNavigation().pop();
        },
        child: Align(
            alignment: Alignment.topLeft,
            child: Icon(Icons.close,
                color: AppColorHelper.getIconColor(colorMode))),
      ),
    );
  }
}
