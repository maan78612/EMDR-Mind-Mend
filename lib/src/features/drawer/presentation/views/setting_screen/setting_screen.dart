import 'package:audioplayers/audioplayers.dart';
import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/commons/custom_navigation.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/views/setting_screen/widget/auditory_tab.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/views/setting_screen/widget/setting_tab_buttons.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/views/setting_screen/widget/visual_tab.dart';
import 'package:emdr_mindmend/src/features/drawer/presentation/widgets/drawer_widgets_app_bar.dart';
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
    ref.read(settingViewModelProvider).audioPlayer = AudioPlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final settingViewModel = ref.watch(settingViewModelProvider);

    return Material(
      child: Scaffold(
        backgroundColor: AppColors.whiteBg,
        appBar: DrawerAppBar(
          title: 'Settings',
          onBack: () {
            CustomNavigation().pop();
            settingViewModel.stopSound();
            settingViewModel.audioPlayer.dispose();
          },
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: hMargin),
          child: Column(
            children: [
              30.verticalSpace,
              const SettingTabButtons(),
              (settingViewModel.settingPageIndex == 0)
                  ? const AuditoryTab()
                  : const VisualTab(),
              if (settingViewModel.isPlaying)
                CommonInkWell(
                  onTap: () {
                    settingViewModel.stopSound();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.redColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.stop,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
