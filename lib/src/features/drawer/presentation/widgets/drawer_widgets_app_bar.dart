import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;
  final Color? bgColor;
  final void Function()? onBack;

  const DrawerAppBar(
      {super.key, required this.title, this.bgColor, this.onBack})
      : preferredSize = const Size.fromHeight(kToolbarHeight + 10.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      backgroundColor: bgColor ?? AppColors.whiteBg,
      leading: CommonInkWell(
        onTap: onBack ??
            () {
              CustomNavigation().pop();
            },
        child: const Icon(
          Icons.arrow_back_ios,
          color: AppColors.blackColor,
        ),
      ),
      title: Text(
        title,
        style: PoppinsStyles.medium.copyWith(fontSize: 18.sp),
      ),
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(2),
        child: Divider(color: AppColors.borderColor),
      ),
    );
  }
}
