import 'package:emdr_mindmend/src/core/commons/custom_button.dart';
import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/commons/loader.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/constants/images.dart';
import 'package:emdr_mindmend/src/core/enums/color_enum.dart';
import 'package:emdr_mindmend/src/core/enums/snackbar_status.dart';
import 'package:emdr_mindmend/src/core/manager/color_manager.dart';
import 'package:emdr_mindmend/src/core/utilities/custom_snack_bar.dart';
import 'package:emdr_mindmend/src/features/auth/domain/models/user.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/viewmodels/drawer_viewmodel.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/views/contact_us.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/views/help_faq_screen/help_faq_screen.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/views/profile_screen/profile_screen.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/views/setting_screen/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'widgets/theme_switcher.dart';

class DrawerScreen extends ConsumerStatefulWidget {
  const DrawerScreen({super.key});

  @override
  ConsumerState<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends ConsumerState<DrawerScreen> {
  final drawerViewModelProvider =
      ChangeNotifierProvider<DrawerViewModel>((ref) {
    return DrawerViewModel();
  });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final drawerViewModel = ref.watch(drawerViewModelProvider);
    final userData = ref.watch(userModelProvider);
    final colorMode = ref.watch(colorModeProvider);
    return CustomLoader(
      isLoading: drawerViewModel.isLoading,
      child: Scaffold(
        backgroundColor: AppColorHelper.getScaffoldColor(colorMode),
        body: CustomLoader(
          isLoading: drawerViewModel.isLoading,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: hMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  header(userData, colorMode),
                  const Spacer(),
                  _ThemeSwitcher(),
                  drawerOption(
                      img: AppImages.myProfile,
                      title: "My Profile",
                      onTap: () async {
                        await CustomNavigation().push(ProfileScreen());
                      },
                      colorMode: colorMode),
                  drawerOption(
                      img: AppImages.setting,
                      title: "Settings",
                      onTap: () {
                        CustomNavigation().push(const SettingScreen());
                      },
                      colorMode: colorMode),
                  drawerOption(
                      img: AppImages.contactUs,
                      title: "Contact Us",
                      onTap: () {
                        CustomNavigation().push(ContactUsPage());
                      },
                      colorMode: colorMode),
                  drawerOption(
                      img: AppImages.faq,
                      title: "Helps & FAQs",
                      onTap: () {
                        CustomNavigation().push(HelpFaqPage());
                      }, colorMode: colorMode),
                  const Spacer(flex: 3),
                  drawerOption(
                      img: AppImages.logout,
                      title: "Log Out",
                      onTap: () {
                        _showLogoutDialog(context, drawerViewModel, colorMode);
                      },
                      colorMode: colorMode),
                  80.verticalSpace,
                  CustomButton(
                    bgColor: AppColors.redColor,
                    onPressed: () {
                      _showDeleteDialog(context, drawerViewModel, colorMode);
                    },
                    title: 'Delete Permanently',
                  ),
                  20.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding header(UserModel userData, ColorMode colorMode) {
    return Padding(
      padding: EdgeInsets.only(top: 40.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 40.sp, // Adjust width as needed
            height: 40.sp,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0.r),
                child: userData.image == null
                    ? Image.asset(
                        AppImages.profile,
                        color:
                            AppColors.primaryColor, // Adjust height as needed
                        fit: BoxFit.contain, // Adjust the fit as needed
                      )
                    : Center(
                        child: Image.network(
                          userData.image ?? "",
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error,
                                color: AppColors.redColor);
                          },
                          fit: BoxFit.contain,
                        ),
                      ),
              ),
            ),
          ),
          14.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userData.name,
                  style: PoppinsStyles.semiBold(
                          color: AppColorHelper.getPrimaryTextColor(colorMode))
                      .copyWith(fontSize: 16.sp),
                ),
                6.verticalSpace,
                Text(
                  userData.email,
                  style: PoppinsStyles.light(
                          color: AppColorHelper.getPrimaryTextColor(colorMode))
                      .copyWith(fontSize: 12.sp),
                ),
              ],
            ),
          ),
          closeIcon(colorMode),
        ],
      ),
    );
  }

  Widget drawerOption(
      {required String img,
      required String title,
      required Function onTap,
      required ColorMode colorMode}) {
    return Padding(
      padding: EdgeInsets.only(top: 40.sp),
      child: CommonInkWell(
        onTap: () => onTap(),
        child: Row(
          children: [
            Image.asset(
              img,
              width: 18.sp,
              height: 18.sp,
              fit: BoxFit.contain,
            ),
            16.horizontalSpace,
            Text(
              title,
              style: PoppinsStyles.medium(
                      color: AppColorHelper.getPrimaryTextColor(colorMode))
                  .copyWith(fontSize: 16.sp),
            )
          ],
        ),
      ),
    );
  }

  Widget logo() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
          padding: EdgeInsets.only(top: 60.sp, bottom: 10.sp),
          child:
              Image.asset(AppImages.logo, height: 100.h, fit: BoxFit.contain)),
    );
  }

  Widget closeIcon(ColorMode colorMode) {
    return CommonInkWell(
      onTap: () {
        CustomNavigation().pop();
      },
      child: Align(
          alignment: Alignment.topLeft,
          child: Icon(Icons.close,
              color: AppColorHelper.getIconColor(colorMode))),
    );
  }

  void _showLogoutDialog(BuildContext context, DrawerViewModel drawerViewModel,
      ColorMode colorMode) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          backgroundColor: AppColorHelper.getScaffoldColor(colorMode),
          title: Text(
            'Logout',
            style: PoppinsStyles.semiBold(
                    color: AppColorHelper.getPrimaryTextColor(colorMode))
                .copyWith(fontSize: 16.sp),
          ),
          content: Text('Are you sure you want to log out?',
              style: PoppinsStyles.regular(
                      color: AppColorHelper.getTertiaryTextColor(colorMode))
                  .copyWith(fontSize: 12.sp)),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel',
                  style: PoppinsStyles.medium(
                          color: AppColorHelper.getPrimaryTextColor(colorMode))
                      .copyWith(fontSize: 14.sp)),
              onPressed: () {
                CustomNavigation().pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: Text('Logout',
                  style: PoppinsStyles.medium(color: AppColors.redColor)
                      .copyWith(fontSize: 14.sp)),
              onPressed: () {
                drawerViewModel.logout(
                  showSnackBarMsg: ({
                    required SnackBarType snackType,
                    required String message,
                  }) =>
                      SnackBarUtils.show(message, snackType),
                  ref: ref,
                );
                // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, DrawerViewModel drawerViewModel,
      ColorMode colorMode) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          backgroundColor: AppColorHelper.getScaffoldColor(colorMode),
          title: Text(
            'Delete Permanently',
            style: PoppinsStyles.semiBold(
                    color: AppColorHelper.getPrimaryTextColor(colorMode))
                .copyWith(fontSize: 16.sp),
          ),
          content: Text('Are you sure you want to delete your account?',
              style: PoppinsStyles.regular(
                      color: AppColorHelper.getTertiaryTextColor(colorMode))
                  .copyWith(fontSize: 12.sp)),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel',
                  style: PoppinsStyles.medium(
                          color: AppColorHelper.getPrimaryTextColor(colorMode))
                      .copyWith(fontSize: 14.sp)),
              onPressed: () {
                CustomNavigation().pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: Text('delete',
                  style: PoppinsStyles.medium(color: AppColors.redColor)
                      .copyWith(fontSize: 14.sp)),
              onPressed: () {
                drawerViewModel.deleteUser(
                  showSnackBarMsg: ({
                    required SnackBarType snackType,
                    required String message,
                  }) =>
                      SnackBarUtils.show(message, snackType),
                  ref: ref,
                );
                // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
