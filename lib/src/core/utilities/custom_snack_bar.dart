
import 'package:another_flushbar/flushbar.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/enums/snackbar_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSnackBar {
  static void showSnackBar(
      String msg, SnackBarType type, BuildContext context) {
    Flushbar(
      title: type.name.toUpperCase(),
      titleColor: Colors.white,
      message: msg,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: getTypeColor(type),
      isDismissible: false,
      duration: const Duration(seconds: 2),
      icon: getIcon(type),
    ).show(context);
  }

  static Color getTypeColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.error:
        return AppColors.redColor;
      case SnackBarType.success:
        return AppColors.greenColor;
      case SnackBarType.info:
        return AppColors.primaryColor;
      default:
        return Colors.yellowAccent;
    }
  }

  static Widget getIcon(SnackBarType type) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100.0.r),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(4.sp),
        child: Icon(
          size: 12.sp,
          getTypeIcon(type),
          color: getTypeColor(type),
        ),
      ),
    );
  }

  static IconData getTypeIcon(SnackBarType type) {
    switch (type) {
      case SnackBarType.error:
        return Icons.error;
      case SnackBarType.success:
        return Icons.done;
      case SnackBarType.info:
        return Icons.info;
      default:
        return Icons.warning;
    }
  }
}
