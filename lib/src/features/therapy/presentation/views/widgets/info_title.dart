import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/manager/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoTitle extends ConsumerWidget {
  final String title;

  const InfoTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final colorMode = ref.watch(colorModeProvider);
    return Padding(
      padding: EdgeInsets.only(bottom: 12.sp),
      child: Text(
        title,
        style: PoppinsStyles.semiBold(
            color:
            AppColorHelper.getPrimaryTextColor(colorMode)).copyWith(fontSize: 18.sp),
      ),
    );
  }
}
