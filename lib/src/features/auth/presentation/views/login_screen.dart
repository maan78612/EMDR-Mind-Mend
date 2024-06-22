
import 'package:emdr_mindmend/src/core/commons/custom_button.dart';
import 'package:emdr_mindmend/src/core/commons/custom_input_field.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/constants/images.dart';
import 'package:emdr_mindmend/src/core/constants/text_field_validator.dart';
import 'package:emdr_mindmend/src/features/auth/presentation/viewmodels/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends ConsumerWidget {
  final loginViewModelProvider = ChangeNotifierProvider<LoginViewModel>((ref) {
    return LoginViewModel();
  });

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginViewModel = ref.watch(loginViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: hMargin),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppImages.appIcon,
                  width: 180.w,
                ),
                35.verticalSpace,
                Text(
                  "Welcome",
                  style: PoppinsStyles.semiBold
                      .copyWith(fontSize: 24.sp, color: AppColors.blackColor),
                ),
                21.verticalSpace,
                Text(
                  "Please enter your details below to login",
                  style: PoppinsStyles.regular,
                ),
                35.verticalSpace,
                CustomInputField(
                  title: "User ID",
                  hint: "Enter user ID",
                  controller: loginViewModel.uIdCon,
                  onChange: (value) {
                    loginViewModel.onChange(
                        con: loginViewModel.uIdCon,
                        value: value,
                        validator: TextFieldValidator.validateUid);
                  },
                ),
                21.verticalSpace,
                CustomInputField(
                  title: "Password",
                  hint: "Enter password",
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
                CustomButton(
                  title: 'Login',
                  isEnable: loginViewModel.isBtnEnable,
                  bgColor: AppColors.primaryColor,
                  onPressed: () {
                    loginViewModel.login();
                  },
                ),
                30.verticalSpace,
                CustomInputField(
                  title: "Tenant URL",
                  hint: "Enter tenant url",
                  controller: loginViewModel.tenantCon,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
