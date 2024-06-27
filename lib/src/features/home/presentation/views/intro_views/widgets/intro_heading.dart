import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroHeading extends StatelessWidget {
  final String heading;

  const IntroHeading({super.key, required this.heading});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.sp),
      child: Text(
        heading,
        style: PoppinsStyles.bold.copyWith(fontSize: 24.sp),
      ),
    );
  }
}
