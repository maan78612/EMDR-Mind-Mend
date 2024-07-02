import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/commons/loader.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/constants/images.dart';
import 'package:emdr_mindmend/src/core/enums/snackbar_status.dart';
import 'package:emdr_mindmend/src/core/utilities/custom_snack_bar.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/viewmodels/drawer_viewmodel.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/views/contact_us.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/views/help_faq_screen/help_faq_screen.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/views/profile_screen/profile_screen.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/views/setting_screen/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

    return CustomLoader(
      isLoading: drawerViewModel.isLoading,
      child: Scaffold(
        backgroundColor: AppColors.whiteBg,
        body: CustomLoader(
          isLoading: drawerViewModel.isLoading,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: hMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  header(),
                  const Spacer(),
                  drawerOption(
                      img: AppImages.myProfile,
                      title: "My Profile",
                      onTap: () {
                        CustomNavigation().push(ProfileScreen());
                      }),
                  drawerOption(
                      img: AppImages.settings,
                      title: "Settings",
                      onTap: () {
                        CustomNavigation().push(const SettingScreen());
                      }),
                  drawerOption(
                      img: AppImages.contactUs,
                      title: "Contact Us",
                      onTap: () {
                        CustomNavigation().push(ContactUsPage());
                      }),
                  drawerOption(
                      img: AppImages.faq,
                      title: "Helps & FAQs",
                      onTap: () {
                        CustomNavigation().push(HelpFaqPage());
                      }),
                  const Spacer(flex: 3),
                  drawerOption(
                      img: AppImages.logout,
                      title: "Log Out",
                      onTap: () {
                        _showLogoutDialog(context, drawerViewModel);
                      }),
                  40.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding header() {
    return Padding(
      padding: EdgeInsets.only(top: 40.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0.r),
            // Adjust the radius as needed
            child: Image.asset(
              AppImages.profilePic,
              width: 40.sp, // Adjust width as needed
              height: 40.sp, // Adjust height as needed
              fit: BoxFit.cover, // Adjust the fit as needed
            ),
          ),
          14.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hari Ran",
                style: PoppinsStyles.semiBold.copyWith(fontSize: 16.sp),
              ),
              6.verticalSpace,
              Text(
                "hariran@gmail.com",
                style: PoppinsStyles.light.copyWith(fontSize: 12.sp),
              ),
            ],
          ),
          const Spacer(),
          closeIcon(),
        ],
      ),
    );
  }

  Widget drawerOption(
      {required String img, required String title, required Function onTap}) {
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
              style: PoppinsStyles.medium.copyWith(fontSize: 16.sp),
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

  Widget closeIcon() {
    return CommonInkWell(
      onTap: () {
        CustomNavigation().pop();
      },
      child: const Align(
          alignment: Alignment.topLeft,
          child: Icon(Icons.close, color: AppColors.blackColor)),
    );
  }

  void _showLogoutDialog(
      BuildContext context, DrawerViewModel drawerViewModel) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          backgroundColor: AppColors.whiteColor,
          title: Text(
            'Logout',
            style: PoppinsStyles.semiBold.copyWith(fontSize: 16.sp),
          ),
          content: Text('Are you sure you want to log out?',
              style: PoppinsStyles.regular
                  .copyWith(fontSize: 12.sp, color: AppColors.greyColor)),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel',
                  style: PoppinsStyles.medium.copyWith(fontSize: 14.sp)),
              onPressed: () {
                CustomNavigation().pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: Text('Logout',
                  style: PoppinsStyles.medium
                      .copyWith(fontSize: 14.sp, color: AppColors.redColor)),
              onPressed: () {
                drawerViewModel.logout(
                  showSnackBarMsg: ({
                    required SnackBarType snackType,
                    required String message,
                  }) =>
                      CustomSnackBar.showSnackBar(message, snackType, context),
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
