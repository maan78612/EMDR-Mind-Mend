import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/enums/color_enum.dart';
import 'package:emdr_mindmend/src/core/manager/color_manager.dart';
import 'package:emdr_mindmend/src/features/profile/presentation/viewmodels/edit_profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ImageOptionsDialog extends ConsumerWidget {
  final ChangeNotifierProvider<EditProfileViewModel>
      editProfileViewModelProvider;

  const ImageOptionsDialog(
      {super.key, required this.editProfileViewModelProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editProfileViewModel = ref.watch(editProfileViewModelProvider);
    final colorMode = ref.watch(colorModeProvider);
    return Container(
      width: 0.85.sw,
      decoration: BoxDecoration(
        color: AppColorHelper.getScaffoldColor(colorMode),
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildDialogHeader(context),
          20.verticalSpace,
          _buildOptionRow(editProfileViewModel, colorMode),
          30.verticalSpace,
        ],
      ),
    );
  }

  Widget _buildDialogHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.close, color: Colors.transparent),
          ),
          const Spacer(),
          Text(
            "Choose Media",
            style: PoppinsStyles.semiBold(color: AppColors.whiteColor),
          ),
          const Spacer(),
          CommonInkWell(
            onTap: () => CustomNavigation().pop(),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.close, color: AppColors.whiteColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionRow(
      EditProfileViewModel editProfileViewModel, ColorMode colorMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildOption(
          icon: Icons.camera_enhance_rounded,
          label: "Camera",
          onTap: () async {
            await editProfileViewModel.imageOptionClick(ImageSource.camera);
            CustomNavigation().pop();
          },
          colorMode: colorMode,
        ),
        _buildOption(
          icon: Icons.image,
          label: "Gallery",
          onTap: () async {
            await editProfileViewModel.imageOptionClick(ImageSource.gallery);
            CustomNavigation().pop();
          },
          colorMode: colorMode,
        ),
      ],
    );
  }

  Widget _buildOption(
      {required IconData icon,
      required String label,
      required VoidCallback onTap,
      required ColorMode colorMode}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CommonInkWell(
          onTap: onTap,
          child: Container(
            width: 70.sp,
            height: 70.sp,
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorMode == ColorMode.light
                  ? AppColors.primaryColor.withOpacity(0.3)
                  : AppColors.primaryColor.withOpacity(0.3),
            ),
            child: Center(
              child: Icon(icon,
                  color: colorMode == ColorMode.light
                      ? AppColors.blackColor
                      : AppColors.whiteColor,
                  size: 40.sp),
            ),
          ),
        ),
        10.verticalSpace,
        Text(
          label,
          style: PoppinsStyles.regular(
                  color: AppColorHelper.getPrimaryTextColor(colorMode))
              .copyWith(fontSize: 12.sp),
        ),
      ],
    );
  }
}
