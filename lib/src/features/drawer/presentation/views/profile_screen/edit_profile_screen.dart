import 'package:country_picker/country_picker.dart';
import 'package:emdr_mindmend/src/core/commons/custom_button.dart';
import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/commons/custom_input_field.dart';
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
import 'package:emdr_mindmend/src/features/drawer/presentation/viewmodels/edit_profile_viewmodel.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/views/widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

part 'widget/dob_picker.dart';

part 'widget/country_picker.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<EditProfileScreen> {
  final editProfileViewModelProvider =
      ChangeNotifierProvider<EditProfileViewModel>((ref) {
    return EditProfileViewModel();
  });

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(editProfileViewModelProvider)
          .initMethod(ref.read(userModelProvider));
    });
    super.initState();
  }

  final radius = 120.sp;

  @override
  Widget build(BuildContext context) {
    final editProfileViewModel = ref.watch(editProfileViewModelProvider);

    final colorMode = ref.watch(colorModeProvider);
    return CustomLoader(
      isLoading: editProfileViewModel.isLoading,
      child: Scaffold(
          backgroundColor: AppColorHelper.getScaffoldColor(colorMode),
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            title: Text(
              "My Profile",
              style: PoppinsStyles.semiBold(
                      color: colorMode == ColorMode.light
                          ? const Color(0xff106E27)
                          : Colors.white)
                  .copyWith(fontSize: 18.sp),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: radius / 2),
              child: SingleChildScrollView(
                clipBehavior: Clip.none,
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        _profileCard(colorMode, editProfileViewModel),
                        Positioned(
                          top: -radius / 2,
                          child: ProfileImage(
                              editProfileViewModelProvider:
                                  editProfileViewModelProvider,
                              radius: radius),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget _profileCard(
      ColorMode colorMode, EditProfileViewModel editProfileViewModel) {
    return Card(
        elevation: 5,
        color: colorMode == ColorMode.light
            ? AppColors.whiteColor
            : AppColors.darkCardColor,
        margin: EdgeInsets.symmetric(horizontal: hMargin),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: radius / 2),
              CustomInputField(
                title: "Name",
                colorMode: colorMode,
                prefixWidget: Image.asset(
                  AppImages.person,
                  color: AppColorHelper.getIconColor(colorMode),
                  width: 16.sp,
                  height: 16.sp,
                  fit: BoxFit.contain,
                ),
                hint: "Name",
                textInputAction: TextInputAction.next,
                controller: editProfileViewModel.nameCon,
                onChange: (value) {
                  editProfileViewModel.onChange(
                      con: editProfileViewModel.nameCon,
                      value: value,
                      validator: TextFieldValidator.validatePersonName);
                },
              ),
              CustomInputField(
                title: "Email",
                prefixWidget: Image.asset(
                  AppImages.email,
                  color: AppColorHelper.getIconColor(colorMode),
                ),
                hint: "Email",
                colorMode: colorMode,
                enable: false,
                controller: editProfileViewModel.emailCon,
                textStyle: PoppinsStyles.regular(color: AppColors.greyColor)
                    .copyWith(fontSize: 15.sp),
              ),
              _CountryPickerWidget(
                  editProfileViewModelProvider: editProfileViewModelProvider),
              _DOBPickerWidget(
                  editProfileViewModelProvider: editProfileViewModelProvider),
              40.verticalSpace,
              CustomButton(
                onPressed: () async {
                  await editProfileViewModel.editProfile(
                      showSnackBarMsg: ({
                        required SnackBarType snackType,
                        required String message,
                      }) =>
                          SnackBarUtils.show(message, snackType),
                      ref: ref);
                },
                bgColor: AppColors.primaryColor,
                title: 'Update Profile',
              ),
              40.verticalSpace,
            ],
          ),
        ));
  }
}
