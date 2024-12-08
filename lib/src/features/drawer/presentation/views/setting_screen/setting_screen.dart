import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/fonts.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/enums/color_enum.dart';
import 'package:emdr_mindmend/src/core/manager/color_manager.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/views/setting_screen/widget/auditory_tab.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/views/setting_screen/widget/setting_tab_buttons.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/views/setting_screen/widget/visual_tab.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/views/widgets/drawer_widgets_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final settingViewModel = ref.watch(settingViewModelProvider);
    final colorMode = ref.watch(colorModeProvider);

    return Scaffold(
      backgroundColor: AppColorHelper.getScaffoldColor(colorMode),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: Text(
          "Settings",
          style: PoppinsStyles.semiBold(
                  color: colorMode == ColorMode.light
                      ? const Color(0xff106E27)
                      : Colors.white)
              .copyWith(fontSize: 18.sp),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: hMargin),
          child: Column(
            children: [
              const SettingTabButtons(),
              (settingViewModel.settingPageIndex == 0)
                  ? const AuditoryTab()
                  : const VisualTab(),
            ],
          ),
        ),
      ),
    );
  }
}
