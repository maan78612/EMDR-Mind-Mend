import 'package:emdr_mindmend/src/core/commons/custom_button.dart';
import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/commons/custom_input_field.dart';
import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/constants/images.dart';
import 'package:emdr_mindmend/src/core/constants/text_field_validator.dart';
import 'package:emdr_mindmend/src/features/auth/presentation/viewmodels/forget_pass_viewmodel.dart';
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
                Image.asset(
                  AppImages.logo,
                  width: 100.sp,
                ),
                30.verticalSpace,
                Text(
                  "Forget Password!",
                  style: PoppinsStyles.bold.copyWith(fontSize: 22.sp),
                ),
                10.verticalSpace,
                Text(
                  "Please enter your email to get reset link",
                  style: PoppinsStyles.regular
                      .copyWith(fontSize: 14.sp, color: AppColors.greyColor),
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
                ),
                CustomButton(
                  title: 'Submit',
                  isEnable: forgetPassViewModel.isBtnEnable,
                  bgColor: AppColors.primaryColor,
                  onPressed: () {
                    forgetPassViewModel.forgetPass();
                  },
                ),
                40.verticalSpace,
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
          CustomNavigation().pop();
        },
        child: const Align(
            alignment: Alignment.topLeft,
            child: Icon(Icons.close, color: AppColors.blackColor)),
      ),
    );
  }
}
