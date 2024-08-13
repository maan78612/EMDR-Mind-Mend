import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String description;
  final String btnTitle;
  final VoidCallback onTap;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.description,
    required this.btnTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.symmetric(vertical: 6.sp),
      contentPadding: EdgeInsets.symmetric(vertical: 4.sp,horizontal: 8.sp),
      backgroundColor: const Color(0xff1E1E1E).withOpacity(0.75),
      alignment: Alignment.center,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: PoppinsStyles.semiBold
            .copyWith(fontSize: 15.sp, color: AppColors.whiteColor),
      ),
      content: Text(
        description,
        textAlign: TextAlign.center,
        style: PoppinsStyles.light.copyWith(
            fontSize: 12.sp, color: AppColors.whiteColor, height: 1.2.sp),
      ),
      actions: [
        CommonInkWell(
          onTap: onTap,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(8.sp),
              child: Text(btnTitle,
                  textAlign: TextAlign.center,
                  style: PoppinsStyles.semiBold
                      .copyWith(fontSize: 15.sp, color: AppColors.whiteColor)),
            ),
          ),
        ),
      ],
    );
  }
}
