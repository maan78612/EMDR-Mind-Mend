import 'dart:io';

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
import 'package:emdr_mindmend/src/core/enums/snackbar_status.dart';
import 'package:emdr_mindmend/src/core/manager/color_manager.dart';
import 'package:emdr_mindmend/src/core/utilities/custom_snack_bar.dart';
import 'package:emdr_mindmend/src/features/auth/presentation/viewmodels/login_viewmodel.dart';
import 'package:emdr_mindmend/src/features/auth/presentation/views/forget_password.dart';
import 'package:emdr_mindmend/src/features/auth/presentation/views/sign_up_screen.dart';
import 'package:emdr_mindmend/src/features/on_boarding/presentation/views/on_boarding_screen.dart';
import 'package:emdr_mindmend/src/features/splash/domain/models/credential_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final CredentialsModel? credentialsModel;

  const LoginScreen({super.key, this.credentialsModel});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final loginViewModelProvider = ChangeNotifierProvider<LoginViewModel>((ref) {
    return LoginViewModel();
  });

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.credentialsModel != null) {
        ref.read(loginViewModelProvider).autoLogin(
            showSnackBarMsg: ({
              required SnackBarType snackType,
              required String message,
            }) =>
                SnackBarUtils.show(message, snackType),
            credentials: widget.credentialsModel!,
            ref: ref);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginViewModel = ref.watch(loginViewModelProvider);
    final colorMode = ref.watch(colorModeProvider);
    return CustomLoader(
      isLoading: loginViewModel.isLoading,
      child: Scaffold(
        backgroundColor: AppColorHelper.getScaffoldColor(colorMode),
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
                    style: PoppinsStyles.bold(
                            color:
                                AppColorHelper.getPrimaryTextColor(colorMode))
                        .copyWith(fontSize: 22.sp),
                  ),
                  10.verticalSpace,
                  Text(
                    "Please enter your account here",
                    style: PoppinsStyles.regular(
                            color:
                                AppColorHelper.getPrimaryTextColor(colorMode))
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
                    colorMode: colorMode,
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
                    colorMode: colorMode,
                  ),
                  21.verticalSpace,
                  CommonInkWell(
                    onTap: () {
                      CustomNavigation().push(ForgetPasswordScreen());
                    },
                    child: Text("Forgot Password?",
                        style:
                            PoppinsStyles.medium(color: AppColors.primaryColor)
                                .copyWith(
                          fontSize: 15.sp,
                        )),
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
                              SnackBarUtils.show(message, snackType),
                          ref: ref);
                    },
                  ),
                  40.verticalSpace,
                  separator(colorMode),
                  30.verticalSpace,
                  socialLoginButtons(loginViewModel, context),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.sp),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Don’t have an account? ",
                            style: PoppinsStyles.regular(
                                    color: AppColorHelper.getPrimaryTextColor(
                                        colorMode))
                                .copyWith(fontSize: 16.sp),
                          ),
                          WidgetSpan(
                            child: CommonInkWell(
                                onTap: () {
                                  loginViewModel.clearForm();
                                  CustomNavigation().push(SignUpScreen());
                                },
                                child: Text(
                                  " Sign Up",
                                  style: PoppinsStyles.bold(
                                          color: AppColorHelper
                                              .getPrimaryTextColor(colorMode))
                                      .copyWith(
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

  Widget socialLoginButtons(
      LoginViewModel loginViewModel, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CommonInkWell(
            onTap: () {
              loginViewModel.googleLogin(
                  showSnackBarMsg: ({
                    required SnackBarType snackType,
                    required String message,
                  }) =>
                      SnackBarUtils.show(message, snackType),
                  ref: ref);
            },
            child: Container(
              height: inputFieldHeight,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor),
                  borderRadius: BorderRadius.all(Radius.circular(10.r))),
              child: Center(
                child: Image.asset(
                  AppImages.google,
                  height: 27.sp,
                  width: 27.sp,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        15.horizontalSpace,
        if (Platform.isIOS)
          Expanded(
            child: CommonInkWell(
              onTap: () {
                loginViewModel.appleLogin(
                    showSnackBarMsg: ({
                      required SnackBarType snackType,
                      required String message,
                    }) =>
                        SnackBarUtils.show(message, snackType),
                    ref: ref);
              },
              child: Container(
                height: inputFieldHeight,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderColor),
                    borderRadius: BorderRadius.all(Radius.circular(10.r))),
                child: Center(
                  child: Image.asset(
                    AppImages.apple,
                    height: 27.sp,
                    width: 27.sp,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }

  Widget separator(ColorMode colorMode) {
    return Row(
      children: [
         Expanded(
          child: Divider(
            endIndent: 30,
            indent: 10,
            color: AppColorHelper.dividerColor(colorMode),
            height: 1,
          ),
        ),
        Text(
          'OR',
          style: PoppinsStyles.medium(color: const Color(0xff6B7280)).copyWith(
            fontSize: 15.sp,
          ),
        ),
         Expanded(
          child: Divider(
            endIndent: 10,
            indent: 30,
            color: AppColorHelper.dividerColor(colorMode),
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
          CustomNavigation()
              .pushAndRemoveUntil(const OnBoardingScreen(), animate: false);
        },
        child: const Align(
            alignment: Alignment.topLeft,
            child: Icon(Icons.close, color: AppColors.lightPrimaryTextColor)),
      ),
    );
  }
}
