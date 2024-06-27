import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroDescription extends StatelessWidget {
  final String description;
  final String? boldDescription;
  final bool isBullet;

  const IntroDescription(
      {super.key,
      required this.description,
      this.isBullet = false,
      this.boldDescription});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isBullet)
          Container(
            width: 7.sp,
            height: 7.sp,
            margin: EdgeInsets.only(right: 6.sp,top: 6.sp),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Color(0xffDB902C)),
          ),
        Expanded(
          child: RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              children: [
                TextSpan(
                  text: boldDescription ?? "",
                  style: PoppinsStyles.semiBold.copyWith(fontSize: 14.sp,height: 1.2.sp),
                ),
                TextSpan(
                  text: description,
                  style: PoppinsStyles.light.copyWith(
                      fontSize: 14.sp, color: const Color(0xff424242),height: 1.2.sp),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}