
import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogBoxUtils {
  static Future<bool?> show(Widget child, {bool isDismissible=false}) async {
   return await showDialog<bool>(
      context: CustomNavigation().navigatorKey.currentContext!,
      barrierDismissible: isDismissible,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          backgroundColor: AppColors.whiteColor,
          child: child,
        );
      },
    );
  }
}
