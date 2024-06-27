import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroTitle extends StatelessWidget {
  final String title;

  const IntroTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.sp),
      child: Text(
        title,
        style: PoppinsStyles.semiBold.copyWith(fontSize: 18.sp),
      ),
    );
  }
}
