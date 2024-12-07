import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/manager/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class infoHeading extends ConsumerWidget {
  final String heading;

  const infoHeading({super.key, required this.heading});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorMode = ref.watch(colorModeProvider);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.sp),
      child: Text(
        heading,
        style: PoppinsStyles.bold(
                color: AppColorHelper.getPrimaryTextColor(colorMode))
            .copyWith(fontSize: 24.sp),
      ),
    );
  }
}
