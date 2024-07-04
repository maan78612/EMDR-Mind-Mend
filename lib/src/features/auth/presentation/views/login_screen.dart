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
import 'package:emdr_mindmend/src/features/auth/presentation/viewmodels/login_viewmodel.dart';
import 'package:emdr_mindmend/src/features/auth/presentation/views/forget_password.dart';
import 'package:emdr_mindmend/src/features/auth/presentation/views/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends ConsumerWidget {
  final loginViewModelProvider = ChangeNotifierProvider<LoginViewModel>((ref) {
    return LoginViewModel();
  });

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginViewModel = ref.watch(loginViewModelProvider);

    return CustomLoader(
      isLoading: loginViewModel.isLoading,
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
                    "Welcome Back!",
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
                    prefixWidget: Image.asset(AppImages.email),
                    hint: "Email",
                    textInputAction: TextInputAction.next,
                    controller: loginViewModel.emailCon,
                    onChange: (value) {
                      loginViewModel.onChange(
                          con: loginViewModel.emailCon,
                          value: value,
                          validator: TextFieldValidator.validateEmail);
                    },
                  ),
                  CustomInputField(
                    prefixWidget: Image.asset(AppImages.password),
                    hint: "Password",
                    textInputAction: TextInputAction.done,
                    controller: loginViewModel.passwordCon,
                    onChange: (value) {
                      loginViewModel.onChange(
                          con: loginViewModel.passwordCon,
                          value: value,
                          validator: TextFieldValidator.validatePassword);
                    },
                    obscure: true,
                  ),
                  21.verticalSpace,
                  CommonInkWell(
                    onTap: () {
                      CustomNavigation().push(ForgetPasswordScreen());
                    },
                    child: Text(
                      "Forgot Password?",
                      style: PoppinsStyles.medium.copyWith(
                          fontSize: 15.sp, color: AppColors.primaryColor),
                    ),
                  ),
                  21.verticalSpace,
                  CustomButton(
                    title: 'Login',
                    isEnable: loginViewModel.isBtnEnable,
                    bgColor: AppColors.primaryColor,
                    onPressed: () {
                      loginViewModel.login(
                          showSnackBarMsg: ({
                        required SnackBarType snackType,
                        required String message,
                      }) =>
                              CustomSnackBar.showSnackBar(
                                  message, snackType, context));
                    },
                  ),
                  40.verticalSpace,
                  separator(),
                  30.verticalSpace,
                  socialLoginButtons(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.sp),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Don’t have an account? ",
                            style:
                                PoppinsStyles.regular.copyWith(fontSize: 16.sp),
                          ),
                          WidgetSpan(
                            child: CommonInkWell(
                                onTap: () {
                                  loginViewModel.clearForm();
                                  CustomNavigation().push(SignUpScreen());
                                },
                                child: Text(
                                  " Sign Up",
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

  Widget socialLoginButtons() {
    return Row(
      children: [
        Expanded(
          child: CommonInkWell(
            onTap: () {},
            child: Container(
              height: inputFieldHeight,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor),
                  borderRadius: BorderRadius.all(Radius.circular(10.r))),
              child: Image.asset(
                AppImages.google,
              ),
            ),
          ),
        ),
        15.horizontalSpace,
        Expanded(
          child: CommonInkWell(
            onTap: () {},
            child: Container(
              height: inputFieldHeight,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor),
                  borderRadius: BorderRadius.all(Radius.circular(10.r))),
              child: Image.asset(
                AppImages.apple,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget separator() {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            endIndent: 30,
            indent: 10,
            color: AppColors.borderColor,
            height: 1,
          ),
        ),
        Text(
          'OR',
          style: PoppinsStyles.medium
              .copyWith(fontSize: 15.sp, color: const Color(0xff6B7280)),
        ),
        const Expanded(
          child: Divider(
            endIndent: 10,
            indent: 30,
            color: AppColors.borderColor,
            height: 1,
          ),
        ),
      ],
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
