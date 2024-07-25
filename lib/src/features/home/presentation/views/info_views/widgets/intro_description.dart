import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class IntroDescription extends StatelessWidget {
//   final String description;
//   final String? boldDescriptionStart;
//   final String? boldDescriptionEnd;
//   final bool isBullet;
//
//   const IntroDescription({
//     super.key,
//     required this.description,
//     this.isBullet = false,
//     this.boldDescriptionStart,
//     this.boldDescriptionEnd,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (isBullet)
//           Container(
//             width: 7.sp,
//             height: 7.sp,
//             margin: EdgeInsets.only(right: 6.sp, top: 6.sp),
//             decoration: const BoxDecoration(
//                 shape: BoxShape.circle, color: Color(0xffDB902C)),
//           ),
//         Expanded(
//           child: RichText(
//             textAlign: TextAlign.start,
//             text: TextSpan(
//               children: [
//                 TextSpan(
//                   text: boldDescriptionStart ?? "",
//                   style: PoppinsStyles.semiBold
//                       .copyWith(fontSize: 14.sp, height: 1.2.sp),
//                 ),
//                 TextSpan(
//                   text: description,
//                   style: PoppinsStyles.light.copyWith(
//                       fontSize: 14.sp,
//                       color: const Color(0xff424242),
//                       height: 1.2.sp),
//                 ),
//                 TextSpan(
//                   text: boldDescriptionEnd ?? "",
//                   style: PoppinsStyles.semiBold
//                       .copyWith(fontSize: 14.sp, height: 1.2.sp),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }




class UpdatedIntroDescription<T> extends StatelessWidget {
  final List<T> descriptions;
  final bool isBullet;

  const UpdatedIntroDescription({
    super.key,
    required this.descriptions,
    this.isBullet = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isBullet)
          Container(
            width: 7.sp,
            height: 7.sp,
            margin: EdgeInsets.only(right: 6.sp, top: 6.sp),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffDB902C),
            ),
          ),
        Expanded(
          child: RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              children: descriptions.map((description) {
                if (description is String) {
                  return TextSpan(
                    text: description,
                    style: PoppinsStyles.light.copyWith(
                      fontSize: 14.sp,
                      color: const Color(0xff424242),
                      height: 1.2.sp,
                    ),
                  );
                } else if (description is Map<String, dynamic>) {
                  return TextSpan(
                    text: description['text'],
                    style: PoppinsStyles.semiBold.copyWith(
                      fontSize: 14.sp,
                      height: 1.2.sp,
                    ),
                  );
                } else {
                  throw Exception('Unsupported type');
                }
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
