import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/manager/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoDescriptionWidget<T> extends ConsumerWidget {
  final List<T> descriptions;
  final bool isBullet;

  const InfoDescriptionWidget({
    super.key,
    required this.descriptions,
    this.isBullet = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorMode = ref.watch(colorModeProvider);
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
                    style: PoppinsStyles.light(
                            color:
                                AppColorHelper.getTertiaryTextColor(colorMode))
                        .copyWith(
                      fontSize: 14.sp,
                      height: 1.2.sp,
                    ),
                  );
                } else if (description is Map<String, dynamic>) {
                  return TextSpan(
                    text: description['text'],
                    style: PoppinsStyles.semiBold(
                            color:
                                AppColorHelper.getPrimaryTextColor(colorMode))
                        .copyWith(
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
