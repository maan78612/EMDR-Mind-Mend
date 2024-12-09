import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/commons/loader.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/constants/images.dart';
import 'package:emdr_mindmend/src/core/enums/color_enum.dart';
import 'package:emdr_mindmend/src/core/enums/snackbar_status.dart';
import 'package:emdr_mindmend/src/core/manager/color_manager.dart';
import 'package:emdr_mindmend/src/core/utilities/custom_snack_bar.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/viewmodels/drawer_viewmodel.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/views/contact_us.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/views/help_faq_screen/help_faq_screen.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/views/profile_screen/edit_profile_screen.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/views/widgets/profile_image.dart';
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

  final radius = 120.sp;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final drawerViewModel = ref.watch(drawerViewModelProvider);

    final colorMode = ref.watch(colorModeProvider);
    return CustomLoader(
      isLoading: drawerViewModel.isLoading,
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
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                _cardWidget(colorMode, context, drawerViewModel),
                Positioned(
                  top: -(radius / 2),
                  child: ProfileImage(radius: radius),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardWidget(ColorMode colorMode, BuildContext context,
      DrawerViewModel drawerViewModel) {
    return Card(
      elevation: 5,
      color: colorMode == ColorMode.light
          ? AppColors.whiteColor
          : AppColors.darkCardColor,
      margin: EdgeInsets.only(left: 16.sp, right: 16.sp, bottom: 50.sp),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            (radius / 2).verticalSpace,
            _tiles(
                img: AppImages.myProfile,
                title: "My Profile",
                onTap: () async {
                  await CustomNavigation().push(const EditProfileScreen());
                },
                colorMode: colorMode),
            _tiles(
                img: AppImages.contactUs,
                title: "Contact Us",
                onTap: () {
                  CustomNavigation().push(ContactUsPage());
                },
                colorMode: colorMode),
            _tiles(
                img: AppImages.faq,
                title: "Helps & FAQ's",
                onTap: () {
                  CustomNavigation().push(HelpFaqPage());
                },
                colorMode: colorMode),
            _ThemeSwitcher(),
            _tiles(
                img: AppImages.deleteUser,
                title: 'Delete Account',
                onTap: () {
                  _showDeleteDialog(context, drawerViewModel, colorMode);
                },
                colorMode: colorMode),
            const Spacer(),
            _tiles(
                img: AppImages.logout,
                title: "Log Out",
                onTap: () {
                  _showLogoutDialog(context, drawerViewModel, colorMode);
                },
                colorMode: colorMode),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _tiles(
      {required String img,
      required String title,
      required Function onTap,
      required ColorMode colorMode}) {
    return Padding(
      padding: EdgeInsets.only(top: 20.sp),
      child: CommonInkWell(
        onTap: () => onTap(),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.sp),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorMode == ColorMode.light
                      ? const Color(0xffD1FDBA)
                      : AppColors.primaryColor),
              child: Image.asset(
                img,
                width: 15.sp,
                height: 15.sp,
                fit: BoxFit.contain,
                color: colorMode == ColorMode.light
                    ? const Color(0xff106E27)
                    : Colors.white,
              ),
            ),
            16.horizontalSpace,
            Text(
              title,
              style: PoppinsStyles.medium(
                      color: AppColorHelper.getPrimaryTextColor(colorMode))
                  .copyWith(fontSize: 16.sp),
            ),
            const Spacer(),
            Icon(Icons.chevron_right,
                color: AppColorHelper.getIconColor(colorMode), size: 30.sp)
          ],
        ),
      ),
    );
  }

  Widget _logo() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
          padding: EdgeInsets.only(top: 60.sp, bottom: 10.sp),
          child:
              Image.asset(AppImages.logo, height: 100.h, fit: BoxFit.contain)),
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
