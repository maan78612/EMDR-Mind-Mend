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
import 'package:emdr_mindmend/src/core/enums/snackbar_status.dart';
import 'package:emdr_mindmend/src/core/utilities/custom_snack_bar.dart';
import 'package:emdr_mindmend/src/features/auth/presentation/viewmodels/signup_viewmodel.dart';
import 'package:emdr_mindmend/src/features/auth/presentation/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends ConsumerWidget {
  final signupViewModelProvider = ChangeNotifierProvider<SignViewModel>((ref) {
    return SignViewModel();
  });

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupViewModel = ref.watch(signupViewModelProvider);

    return CustomLoader(
      isLoading: signupViewModel.isLoading,
      child: Scaffold(
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
                    controller: signupViewModel.nameCon,
                    onChange: (value) {
                      signupViewModel.onChange(
                          con: signupViewModel.nameCon,
                          value: value,
                          validator: TextFieldValidator.validatePersonName);
                    },
                  ),
                  CustomInputField(
                    prefixWidget: Image.asset(AppImages.email),
                    hint: "Email",
                    controller: signupViewModel.emailCon,
                    textInputAction: TextInputAction.next,
                    onChange: (value) {
                      signupViewModel.onChange(
                          con: signupViewModel.emailCon,
                          value: value,
                          validator: TextFieldValidator.validateEmail);
                    },
                  ),
                  CustomInputField(
                    prefixWidget: Image.asset(AppImages.password),
                    hint: "Password",
                    controller: signupViewModel.passwordCon,
                    textInputAction: TextInputAction.next,
                    onChange: (value) {
                      signupViewModel.onChange(
                          con: signupViewModel.passwordCon,
                          value: value,
                          validator: TextFieldValidator.validatePassword);
                    },
                    obscure: true,
                  ),
                  CustomInputField(
                    prefixWidget: Image.asset(AppImages.password),
                    hint: "Confirm Password",
                    textInputAction: TextInputAction.done,
                    controller: signupViewModel.confirmPasswordCon,
                    onChange: (value) {
                      signupViewModel.onChange(
                          con: signupViewModel.confirmPasswordCon,
                          value: value,
                          validator: TextFieldValidator.validatePassword);
                    },
                    obscure: true,
                  ),
                  21.verticalSpace,
                  CustomButton(
                    title: 'Sign Up',
                    isEnable: signupViewModel.isBtnEnable,
                    bgColor: AppColors.primaryColor,
                    onPressed: () {
                      signupViewModel.signUpButton(
                        showSnackBarMsg: ({
                          required SnackBarType snackType,
                          required String message,
                        }) =>
                            Utils.showSnackBar(
                                message, snackType, context),
                      );
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
      ),
    );
  }

  Widget closeIcon() {
    return Padding(
      padding: EdgeInsets.only(top: 30.h, bottom: 50.h),
      child: CommonInkWell(
        onTap: () {
          CustomNavigation().pop();
        },
        child: const Align(
            alignment: Alignment.topLeft,
            child: Icon(Icons.close, color: AppColors.blackColor)),
      ),
    );
  }
}
