// dashboard_screen.dart
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:emdr_mindmend/src/core/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:emdr_mindmend/src/core/commons/loader.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/features/dashboard/presentation/viewmodels/dashboard_viewmodel.dart';

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

    return CustomLoader(
      isLoading: dashBoardViewModel.isLoading,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.whiteColor,
        body: _getPage(dashBoardViewModel),
        bottomNavigationBar: _CustomBottomNavigationBar(
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
      case 1:
        return Container();
      case 2:
        return Container();
      case 3:
        return Container();
      case 4:
        return Container();
      default:
        return Container();
    }
  }
}
