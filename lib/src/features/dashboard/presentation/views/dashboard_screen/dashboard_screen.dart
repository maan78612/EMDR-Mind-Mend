
import 'package:emdr_mindmend/src/core/constants/images.dart';
import 'package:emdr_mindmend/src/core/manager/color_manager.dart';
import 'package:emdr_mindmend/src/features/profile/presentation/views/profile_screen.dart';
import 'package:emdr_mindmend/src/features/settings/presentation/views/setting_screen.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/therapy_screen.dart';
import 'package:emdr_mindmend/src/features/user_stats/presentation/views/user_stats_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emdr_mindmend/src/core/commons/loader.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/features/dashboard/presentation/viewmodels/dashboard_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'widgets/bottom_navigation_bar.dart';

class DashBoardScreen extends ConsumerStatefulWidget {
  const DashBoardScreen({super.key});

  @override
  ConsumerState<DashBoardScreen> createState() => _DashBoardScreen();
}

class _DashBoardScreen extends ConsumerState<DashBoardScreen> {
  final _dashBoardViewModelProvider =
      ChangeNotifierProvider<DashBoardViewModel>((ref) => DashBoardViewModel());

  @override
  Widget build(BuildContext context) {
    final dashBoardViewModel = ref.watch(_dashBoardViewModelProvider);
    final colorMode = ref.watch(colorModeProvider);
    return CustomLoader(
      isLoading: dashBoardViewModel.isLoading,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColorHelper.getScaffoldColor(colorMode),
        body: _getPage(dashBoardViewModel),
        bottomNavigationBar: _BottomNavigationBar(
          selectedIndex: dashBoardViewModel.selectedIndex,
          onItemSelected: (index) {
            dashBoardViewModel.selectIndex(index);
          },
        ),
      ),
    );
  }

  Widget _getPage(DashBoardViewModel dashBoardViewModel) {
    switch (dashBoardViewModel.selectedIndex) {
      case 0:
        return const UserStatsScreen();
      case 1:
        return const TherapyScreen(isShort: false);
      case 2:
        return const TherapyScreen(isShort: true);
      case 3:
        return const SettingScreen();
      case 4:
        return const ProfileScreen();
      default:
        return const UserStatsScreen();
    }
  }
}
