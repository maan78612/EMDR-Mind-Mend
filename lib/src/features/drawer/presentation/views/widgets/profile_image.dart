import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/enums/color_enum.dart';
import 'package:emdr_mindmend/src/core/manager/color_manager.dart';
import 'package:emdr_mindmend/src/features/auth/domain/models/user.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/viewmodels/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImage extends ConsumerWidget {
  final double radius;

  final ChangeNotifierProvider<ProfileViewModel>? profileViewModelProvider;

  const ProfileImage(
      {super.key, this.profileViewModelProvider, required this.radius});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userModelProvider);
    final colorMode = ref.watch(colorModeProvider);
    final profileViewModel = profileViewModelProvider != null
        ? ref.watch(profileViewModelProvider!)
        : null;

    return getProfileImageWidget(
      context: context,
      profileViewModel: profileViewModel,
      userData: userData,
      colorMode: colorMode,
    );
  }

  Widget getProfileImageWidget({
    required BuildContext context,
    required ProfileViewModel? profileViewModel,
    required UserModel userData,
    required ColorMode colorMode,
  }) {
    if (profileViewModel != null) {
      // Editable context
      if (profileViewModel.profileImage != null) {
        return imageAddedFromFile(profileViewModel, colorMode);
      } else if (userData.image != null) {
        return imageAddedFromNetwork(
            profileViewModel, context, userData, colorMode);
      } else {
        return noImageAdded(context, profileViewModel, colorMode);
      }
    } else {
      // View-only context
      if (userData.image != null) {
        return Center(
          child: _networkImage(userData),
        );
      } else {
        return Center(
          child: _placeHolderImage(),
        );
      }
    }
  }

  Widget imageAddedFromNetwork(ProfileViewModel profileViewModel,
      BuildContext context, UserModel userData, ColorMode colorMode) {
    return Center(
      child: Stack(
        children: [
          _networkImage(userData),
          positionedIcon(
              colorMode: colorMode,
              icon: Icons.edit,
              onTap: () => _showImageOptions(context, profileViewModel))
        ],
      ),
    );
  }

  Widget _networkImage(UserModel userData) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: NetworkImage(userData.image!),
    );
  }

  Widget noImageAdded(BuildContext context, ProfileViewModel profileViewModel,
      ColorMode colorMode) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _placeHolderImage(),
          positionedIcon(
              colorMode: colorMode,
              icon: Icons.add,
              onTap: () => _showImageOptions(context, profileViewModel))
        ],
      ),
    );
  }

  Widget _placeHolderImage() {
    return CircleAvatar(
      backgroundColor: AppColors.darkSecondaryTextColor,
      radius: radius,
      child: Icon(
        Icons.person,
        size: radius,
        color: AppColors.whiteColor,
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

  Widget imageAddedFromFile(
      ProfileViewModel profileViewModel, ColorMode colorMode) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: radius,
            backgroundImage: Image.file(profileViewModel.profileImage!).image,
          ),
          positionedIcon(
              onTap: profileViewModel.deleteImage,
              colorMode: colorMode,
              iconColor: Colors.red,
              icon: Icons.delete)
        ],
      ),
    );
  }

  Widget positionedIcon(
      {required Function() onTap,
      required ColorMode colorMode,
      required IconData icon,
      Color? iconColor}) {
    double size = radius * 0.35; // Size of the icon container
    return Positioned(
      bottom: size / 2,
      right: size / 2,
      child: CommonInkWell(
        onTap: onTap,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppColorHelper.getScaffoldColor(colorMode),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: size * 0.6, // Adjust icon size inside the container
            color: iconColor ?? AppColorHelper.getIconColor(colorMode),
          ),
        ),
      ),
    );
  }
}
