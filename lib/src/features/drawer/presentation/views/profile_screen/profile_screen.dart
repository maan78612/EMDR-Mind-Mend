import 'dart:io';

import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/commons/custom_input_field.dart';
import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/constants/images.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/viewmodels/profile_viewmodel.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/widgets/drawer_widgets_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends ConsumerWidget {
  ProfileScreen({super.key});

  final profileViewModelProvider =
      ChangeNotifierProvider<ProfileViewModel>((ref) {
    return ProfileViewModel();
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileViewModel = ref.watch(profileViewModelProvider);
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: const DrawerAppBar(title: 'Profile'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: hMargin),
        child: Column(
          children: [
            30.verticalSpace,
            profileViewModel.profileImage != null
                ? CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        Image.file(profileViewModel.profileImage!).image,
                  )
                : CircleAvatar(
                    radius: 50,
                    child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () async {
                        _showImageOptions(context, profileViewModel);
                      },
                    ),
                  ),
            CustomInputField(
              prefixWidget: Image.asset(AppImages.person,
                  color: AppColors.blackColor,
                  width: 16.sp,
                  height: 16.sp,
                  fit: BoxFit.contain),
              hint: "Name",
              textInputAction: TextInputAction.next,
              controller: profileViewModel.nameCon,
              onChange: (value) {},
            ),
            CustomInputField(
              prefixWidget: Image.asset(AppImages.email),
              hint: "Email",
              controller: profileViewModel.emailCon,
            ), // Display email, not editable
            ElevatedButton(
              onPressed: () {},
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _showImageOptions(
      BuildContext context, ProfileViewModel profileViewModel) {
    showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r))),
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
                    style: PoppinsStyles.regular
                        .copyWith(color: AppColors.whiteColor)),
                onTap: () async {
                  await profileViewModel.imageOptionClick(ImageSource.camera);
                  CustomNavigation().pop();
                },
              ),
              const Divider(color: AppColors.whiteColor),
              ListTile(
                leading: const Icon(Icons.image, color: AppColors.whiteColor),
                title: Text('Gallery',
                    style: PoppinsStyles.regular
                        .copyWith(color: AppColors.whiteColor)),
                onTap: () async {
                  await profileViewModel.imageOptionClick(ImageSource.gallery);
                  CustomNavigation().pop();
                },
              ),
              20.verticalSpace
            ],
          ),
        );
      },
    );
  }
}
