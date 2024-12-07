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
import 'package:emdr_mindmend/src/features/auth/domain/models/user.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/viewmodels/profile_viewmodel.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/views/widgets/drawer_widgets_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final profileViewModelProvider =
      ChangeNotifierProvider<ProfileViewModel>((ref) {
    return ProfileViewModel();
  });

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(profileViewModelProvider)
          .initMethod(ref.read(userModelProvider));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileViewModel = ref.watch(profileViewModelProvider);
    final userData = ref.watch(userModelProvider);
    final colorMode = ref.watch(colorModeProvider);
    return CustomLoader(
      isLoading: profileViewModel.isLoading,
      child: Scaffold(
        backgroundColor: AppColorHelper.getScaffoldColor(colorMode),
        appBar: const DrawerAppBar(title: 'Profile'),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: hMargin),
          child: ListView(
            children: [
              30.verticalSpace,
              profileViewModel.profileImage != null
                  ? imageAddedFromFile(profileViewModel, colorMode)
                  : userData.image != null
                      ? imageAddedFromNetwork(
                          profileViewModel, context, userData, colorMode)
                      : noImageAdded(context, profileViewModel),
              30.verticalSpace,
              CustomInputField(
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
                controller: profileViewModel.nameCon,
                onChange: (value) {
                  profileViewModel.onChange(
                      con: profileViewModel.nameCon,
                      value: value,
                      validator: TextFieldValidator.validatePersonName);
                },
              ),
              10.verticalSpace,
              CustomInputField(
                prefixWidget: Image.asset(
                  AppImages.email,
                  color: AppColorHelper.getIconColor(colorMode),
                ),
                hint: "Email",
                colorMode: colorMode,
                enable: false,
                controller: profileViewModel.emailCon,
                textStyle: PoppinsStyles.regular(color: AppColors.greyColor)
                    .copyWith(fontSize: 15.sp),
              ),
              40.verticalSpace,
              CustomButton(
                onPressed: () async {
                  await profileViewModel.editProfile(
                      showSnackBarMsg: ({
                        required SnackBarType snackType,
                        required String message,
                      }) =>
                          SnackBarUtils.show(message, snackType),
                      ref: ref);
                },
                bgColor: AppColors.primaryColor,
                title: 'Save',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageAddedFromFile(
      ProfileViewModel profileViewModel, ColorMode colorMode) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 75,
            backgroundImage: Image.file(profileViewModel.profileImage!).image,
          ),
          Positioned(
            bottom: 7.5.sp,
            right: 7.5.sp,
            child: CommonInkWell(
              onTap: () => profileViewModel.deleteImage(),
              child: CircleAvatar(
                backgroundColor: AppColorHelper.getScaffoldColor(colorMode),
                radius: 15,
                child:
                    Icon(Icons.delete, size: 15.sp, color: AppColors.redColor),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget imageAddedFromNetwork(ProfileViewModel profileViewModel,
      BuildContext context, UserModel userData, ColorMode colorMode) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 75,
            backgroundImage: NetworkImage(
              userData.image!,
            ),
          ),
          Positioned(
            bottom: 7.5.sp,
            right: 7.5.sp,
            child: CommonInkWell(
              onTap: () => _showImageOptions(context, profileViewModel),
              child: CircleAvatar(
                backgroundColor: AppColorHelper.getScaffoldColor(colorMode),
                radius: 15,
                child: Icon(Icons.edit,
                    size: 15.sp, color: AppColors.primaryColor),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget noImageAdded(BuildContext context, ProfileViewModel profileViewModel) {
    return CommonInkWell(
      onTap: () => _showImageOptions(context, profileViewModel),
      child: Center(
        child: Stack(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primaryColor,
              radius: 75,
              child: Icon(
                Icons.person,
                size: 50.sp,
                color: AppColors.whiteColor,
              ),
            ),
            Positioned(
              bottom: 7.5.sp,
              right: 7.5.sp,
              child: CircleAvatar(
                backgroundColor: AppColors.whiteColor,
                radius: 15,
                child: Icon(
                  Icons.add,
                  size: 15.sp,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showImageOptions(
      BuildContext context, ProfileViewModel profileViewModel) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CommonInkWell(
                onTap: () => CustomNavigation().pop(),
                child: const Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.close, color: AppColors.whiteColor),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.camera, color: AppColors.whiteColor),
                title: Text('Camera',
                    style: PoppinsStyles.regular(color: AppColors.whiteColor)),
                onTap: () async {
                  await profileViewModel.imageOptionClick(ImageSource.camera);
                  CustomNavigation().pop();
                },
              ),
              const Divider(color: AppColors.whiteColor),
              ListTile(
                leading: const Icon(Icons.image, color: AppColors.whiteColor),
                title: Text('Gallery',
                    style: PoppinsStyles.regular(color: AppColors.whiteColor)),
                onTap: () async {
                  await profileViewModel.imageOptionClick(ImageSource.gallery);
                  CustomNavigation().pop();
                },
              ),
              20.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}
