import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/manager/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerAppBar extends ConsumerWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;
  final Color? bgColor;
  final void Function()? onBack;

  const DrawerAppBar(
      {super.key, required this.title, this.bgColor, this.onBack})
      : preferredSize = const Size.fromHeight(kToolbarHeight + 10.0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorMode = ref.watch(colorModeProvider);
    return AppBar(
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      backgroundColor: bgColor ?? AppColorHelper.getScaffoldColor(colorMode),
      leading: CommonInkWell(
        onTap: onBack ??
            () {
              CustomNavigation().pop();
            },
        child: Icon(
          Icons.arrow_back_ios,
          color: AppColorHelper.getIconColor(colorMode),
        ),
      ),
      title: Text(
        title,
        style: PoppinsStyles.medium(
            color:
            AppColorHelper.getPrimaryTextColor(colorMode)).copyWith(fontSize: 18.sp),
      ),
      bottom:  PreferredSize(
        preferredSize: const Size.fromHeight(2),
        child: Divider(color: AppColorHelper.dividerColor(colorMode)),
      ),
    );
  }
}
