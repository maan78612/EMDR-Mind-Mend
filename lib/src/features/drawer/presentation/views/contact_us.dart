import 'package:emdr_mindmend/src/core/commons/loader.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/constants/text_field_validator.dart';
import 'package:emdr_mindmend/src/core/enums/color_enum.dart';
import 'package:emdr_mindmend/src/core/enums/snackbar_status.dart';
import 'package:emdr_mindmend/src/core/manager/color_manager.dart';
import 'package:emdr_mindmend/src/core/utilities/custom_snack_bar.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/viewmodels/contact_us_viewmodel.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/views/widgets/drawer_widgets_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:emdr_mindmend/src/core/commons/custom_input_field.dart';
import 'package:emdr_mindmend/src/core/commons/custom_button.dart';

class ContactUsPage extends ConsumerWidget {
  ContactUsPage({super.key});

  final contactUsViewModelProvider =
      ChangeNotifierProvider<ContactUsViewModel>((ref) {
    return ContactUsViewModel();
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactUsViewModel = ref.watch(contactUsViewModelProvider);
    final colorMode = ref.watch(colorModeProvider);
    return CustomLoader(
      isLoading: contactUsViewModel.isLoading,
      child: Scaffold(
        backgroundColor: AppColorHelper.getScaffoldColor(colorMode),
        appBar: const DrawerAppBar(title: "Contact Us"),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomInputField(
                  title: "Name",
                  hint: "Enter your name",
                  controller: contactUsViewModel.nameController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  onChange: (value) {
                    contactUsViewModel.onChange(
                        con: contactUsViewModel.nameController,
                        value: value,
                        validator: TextFieldValidator.validatePersonName);
                  },
                  colorMode: colorMode,
                ),
                20.verticalSpace,
                CustomInputField(
                  colorMode: colorMode,
                  title: "Email",
                  hint: "Enter your email",
                  controller: contactUsViewModel.emailController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  onChange: (value) {
                    contactUsViewModel.onChange(
                        con: contactUsViewModel.emailController,
                        value: value,
                        validator: TextFieldValidator.validateEmail);
                  },
                ),
                20.verticalSpace,
                messageInputField(contactUsViewModel, colorMode),
                30.verticalSpace,
                CustomButton(
                  title: "Submit",
                  isEnable: contactUsViewModel.isBtnEnable,
                  bgColor: AppColors.primaryColor,
                  textColor: AppColors.whiteColor,
                  onPressed: () {
                    contactUsViewModel.submitContactUs(
                        showSnackBarMsg: ({
                      required SnackBarType snackType,
                      required String message,
                    }) =>
                            SnackBarUtils.show(message, snackType));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget messageInputField(
      ContactUsViewModel contactUsViewModel, ColorMode colorMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          onChanged: (value) {
            contactUsViewModel.onChange(
                con: contactUsViewModel.messageController,
                value: value,
                validator: TextFieldValidator.validateMessage);
          },
          controller: contactUsViewModel.messageController.controller,
          maxLines: 5,
          cursorColor: AppColors.primaryColor,
          decoration: InputDecoration(
            hintText: "Enter your message",
            hintStyle: PoppinsStyles.regular(
                    color: AppColorHelper.getSecondaryTextColor(colorMode))
                .copyWith(
              fontSize: 15.sp,
              color: AppColors.hintColor,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 13.sp,
              vertical: 10.sp,
            ),
            filled: true,
            fillColor: AppColorHelper.getScaffoldColor(colorMode),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(
                color: AppColors.borderColor,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(
                color: AppColors.borderColor,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(
                color: AppColors.redColor,
                width: 1,
              ),
            ),
          ),
          style: PoppinsStyles.regular(
                  color: AppColorHelper.getPrimaryTextColor(colorMode))
              .copyWith(fontSize: 15.sp),
        ),
        Padding(
          padding: EdgeInsets.all(6.sp),
          child: Text(
            contactUsViewModel.messageController.error ?? "",
            style: PoppinsStyles.regular(color: AppColors.redColor)
                .copyWith(fontSize: 10.sp),
          ),
        ),
      ],
    );
  }
}
