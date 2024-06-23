import 'package:emdr_mindmend/src/core/commons/custom_button.dart';
import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/commons/custom_input_field.dart';
import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/constants/images.dart';
import 'package:emdr_mindmend/src/core/constants/text_field_validator.dart';
import 'package:emdr_mindmend/src/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:emdr_mindmend/src/features/auth/presentation/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends ConsumerWidget {
  final authViewModelProvider = ChangeNotifierProvider<AuthViewModel>((ref) {
    return AuthViewModel();
  });

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authViewModel = ref.watch(authViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: hMargin),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                closeIcon(),
                Text(
                  "Create Account!",
                  style: PoppinsStyles.bold.copyWith(fontSize: 22.sp),
                ),
                10.verticalSpace,
                Text(
                  "Please enter your account here",
                  style: PoppinsStyles.regular
                      .copyWith(fontSize: 14.sp, color: AppColors.greyColor),
                ),
                35.verticalSpace,
                CustomInputField(
                  prefixWidget: Image.asset(AppImages.person,
                      color: AppColors.blackColor,
                      width: 16.sp,
                      height: 16.sp,
                      fit: BoxFit.contain),
                  hint: "Name",
                  textInputAction: TextInputAction.next,
                  controller: authViewModel.nameCon,
                  onChange: (value) {
                    authViewModel.onChange(
                        con: authViewModel.nameCon,
                        value: value,
                        validator: TextFieldValidator.validatePersonName);
                  },
                ),
                CustomInputField(
                  prefixWidget: Image.asset(AppImages.email),
                  hint: "Email",
                  controller: authViewModel.emailCon,
                  textInputAction: TextInputAction.next,
                  onChange: (value) {
                    authViewModel.onChange(
                        con: authViewModel.emailCon,
                        value: value,
                        validator: TextFieldValidator.validateEmail);
                  },
                ),
                CustomInputField(
                  prefixWidget: Image.asset(AppImages.password),
                  hint: "Password",
                  controller: authViewModel.passwordCon,
                  textInputAction: TextInputAction.next,
                  onChange: (value) {
                    authViewModel.onChange(
                        con: authViewModel.passwordCon,
                        value: value,
                        validator: TextFieldValidator.validatePassword);
                  },
                  obscure: true,
                ),
                CustomInputField(
                  prefixWidget: Image.asset(AppImages.password),
                  hint: "Confirm Password",
                  textInputAction: TextInputAction.done,
                  controller: authViewModel.confirmPasswordCon,
                  onChange: (value) {
                    authViewModel.onChange(
                        con: authViewModel.confirmPasswordCon,
                        value: value,
                        validator: TextFieldValidator.validatePassword);
                  },
                  obscure: true,
                ),
                21.verticalSpace,
                CustomButton(
                  title: 'Sign Up',
                  isEnable: authViewModel.isBtnEnable,
                  bgColor: AppColors.primaryColor,
                  onPressed: () {
                    authViewModel.login();
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.sp),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Already have an account? ",
                          style:
                              PoppinsStyles.regular.copyWith(fontSize: 16.sp),
                        ),
                        WidgetSpan(
                          child: CommonInkWell(
                              onTap: () {
                                CustomNavigation()
                                    .pushReplacement(LoginScreen());
                              },
                              child: Text(
                                " Sign in",
                                style: PoppinsStyles.bold.copyWith(
                                    fontSize: 16.sp,
                                    color: AppColors.primaryColor),
                              )),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget closeIcon() {
    return Padding(
      padding: EdgeInsets.only(top: 30.h, bottom: 50.h),
      child: CommonInkWell(
        onTap: () {
          // CustomNavigation().pop();
        },
        child: const Align(
            alignment: Alignment.topLeft,
            child: Icon(Icons.close, color: AppColors.blackColor)),
      ),
    );
  }
}
