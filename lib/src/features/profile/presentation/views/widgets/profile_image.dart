import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/commons/network_image_with_loader.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/enums/color_enum.dart';
import 'package:emdr_mindmend/src/core/manager/color_manager.dart';
import 'package:emdr_mindmend/src/core/utilities/dialog_box.dart';
import 'package:emdr_mindmend/src/features/auth/domain/models/user.dart';
import 'package:emdr_mindmend/src/features/profile/presentation/viewmodels/edit_profile_viewmodel.dart';
import 'package:emdr_mindmend/src/features/profile/presentation/views/profile_screen/widget/image_option_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImage extends ConsumerWidget {
  final double radius;
  final ChangeNotifierProvider<EditProfileViewModel>?
      editProfileViewModelProvider;

  const ProfileImage(
      {super.key, this.editProfileViewModelProvider, required this.radius});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userModelProvider);
    final colorMode = ref.watch(colorModeProvider);
    final editProfileViewModel = editProfileViewModelProvider != null
        ? ref.watch(editProfileViewModelProvider!)
        : null;

    return getProfileImageWidget(
      context: context,
      editProfileViewModel: editProfileViewModel,
      userData: userData,
      colorMode: colorMode,
    );
  }

  Widget getProfileImageWidget({
    required BuildContext context,
    required EditProfileViewModel? editProfileViewModel,
    required UserModel userData,
    required ColorMode colorMode,
  }) {
    if (editProfileViewModel != null) {
      // Editable context
      if (editProfileViewModel.profileImage != null) {
        return _fileImageWidget(editProfileViewModel, colorMode);
      } else if (userData.image != null) {
        return _networkImageWidget(
            editProfileViewModel, context, userData, colorMode);
      } else {
        return _imagePlaceWidget(context, editProfileViewModel, colorMode);
      }
    } else {
      // View-only context
      if (userData.image != null) {
        return NetworkImageWithLoader(imageUrl: userData.image!, size: radius);
      } else {
        return Center(
          child: _placeHolderImage(),
        );
      }
    }
  }

  Widget _networkImageWidget(EditProfileViewModel editProfileViewModel,
      BuildContext context, UserModel userData, ColorMode colorMode) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          NetworkImageWithLoader(imageUrl: userData.image!, size: radius),
          positionedIcon(
              colorMode: colorMode,
              icon: Icons.edit,
              onTap: () =>
                  _showImageOptions(context, editProfileViewModel, colorMode))
        ],
      ),
    );
  }

  Widget _imagePlaceWidget(BuildContext context,
      EditProfileViewModel editProfileViewModel, ColorMode colorMode) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _placeHolderImage(),
          positionedIcon(
              colorMode: colorMode,
              icon: Icons.add,
              onTap: () =>
                  _showImageOptions(context, editProfileViewModel, colorMode))
        ],
      ),
    );
  }

  Widget _placeHolderImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(1000.sp),
      child: Container(
        width: radius,
        height: radius,
        color: AppColors.lightGreyColor,
        child: Icon(
          Icons.person,
          size: radius,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }

  Widget _fileImageWidget(
      EditProfileViewModel editProfileViewModel, ColorMode colorMode) {
    return Center(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(1000.sp),
            child: Container(
              width: radius,
              height: radius,
              color: AppColors.lightGreyColor,
              child: Image.file(editProfileViewModel.profileImage!),
            ),
          ),
          positionedIcon(
              onTap: editProfileViewModel.deleteImage,
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
    double size = radius * 0.25; // Size of the icon container
    return Positioned(
      bottom: 0,
      right: 0,
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

  void _showImageOptions(BuildContext context,
      EditProfileViewModel editProfileViewModel, ColorMode colorMode) {
    DialogBoxUtils.show(ImageOptionsDialog(
        editProfileViewModelProvider: editProfileViewModelProvider!));
  }
}
