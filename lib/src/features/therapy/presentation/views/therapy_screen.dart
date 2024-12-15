import 'package:emdr_mindmend/src/core/manager/color_manager.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/info_views/welcome_infro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:emdr_mindmend/src/core/commons/custom_inkwell.dart';
import 'package:emdr_mindmend/src/core/commons/loader.dart';
import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/constants/globals.dart';
import 'package:emdr_mindmend/src/core/utilities/custom_snack_bar.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/viewmodels/therapy_viewmodel.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/info_views/info_1.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/info_views/info_2.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/info_views/info_3.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/info_views/info_4.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/info_views/info_5.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/info_views/info_6.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/info_views/info_8.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/info_views/info_9.dart';
import 'package:emdr_mindmend/src/features/therapy/presentation/views/info_views/info_11.dart';

class TherapyScreen extends ConsumerStatefulWidget {
  final bool isShort;

  const TherapyScreen({super.key, required this.isShort});

  @override
  ConsumerState<TherapyScreen> createState() => _TherapyScreenState();
}

class _TherapyScreenState extends ConsumerState<TherapyScreen> {
  final therapyViewModelProvider =
      ChangeNotifierProvider((ref) => TherapyViewModel());
  late TherapyViewModel therapyViewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      therapyViewModel = ref.read(therapyViewModelProvider);
      await therapyViewModel.initializeVideoPlayer();
    });
  }

  @override
  void dispose() {
    // Safely dispose the controller only if the widget is not disposed
    if (mounted) {
      therapyViewModel.resetVideoController();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    therapyViewModel = ref.watch(therapyViewModelProvider);
    final colorMode = ref.watch(colorModeProvider);
    final int totalScreens = widget.isShort ? 4 : 10;

    return Scaffold(
      backgroundColor: AppColorHelper.getScaffoldColor(colorMode),
      body: CustomLoader(
        isLoading: therapyViewModel.isLoading,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: hMargin),
            child: Column(
              children: [
                10.verticalSpace,
                Expanded(
                  child: IndexedStack(
                    index: therapyViewModel.introIndex,
                    children: widget.isShort ? _shortScreens() : _longScreens(),
                  ),
                ),
                _buildNavigationControls(
                    context, therapyViewModel, totalScreens),
                20.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the list of widgets for short screens.
  List<Widget> _shortScreens() {
    return [
      Info6(therapyViewModelProvider: therapyViewModelProvider),
      Info8(therapyViewModelProvider: therapyViewModelProvider),
      Info9(therapyViewModelProvider: therapyViewModelProvider),
      Info11(therapyViewModelProvider: therapyViewModelProvider),
    ];
  }

  /// Builds the list of widgets for long screens.
  List<Widget> _longScreens() {
    return [
      const WelcomeInfo(),
      Info1(therapyViewModelProvider: therapyViewModelProvider),
      const Info2(),
      const Info3(),
      const Info4(),
      Info5(therapyViewModelProvider: therapyViewModelProvider),
      Info6(therapyViewModelProvider: therapyViewModelProvider),
      Info8(therapyViewModelProvider: therapyViewModelProvider),
      Info9(therapyViewModelProvider: therapyViewModelProvider),
      Info11(therapyViewModelProvider: therapyViewModelProvider),
    ];
  }

  /// Builds the navigation controls with back, forward buttons, and dots indicator.
  Widget _buildNavigationControls(BuildContext context,
      TherapyViewModel therapyViewModel, int totalScreens) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonInkWell(
          onTap: therapyViewModel.decrementIndex,
          child: _navigationButton(Icons.arrow_back),
        ),
        _buildDotsIndicator(therapyViewModel.introIndex, totalScreens),
        CommonInkWell(
          onTap: () {
            if (therapyViewModel.incrementIndex(widget.isShort)) {
              therapyViewModel.setScore(
                showSnackBarMsg: ({
                  required snackType,
                  required message,
                }) {
                  SnackBarUtils.show(message, snackType);
                },
              );
            }
          },
          child: _navigationButton(Icons.arrow_forward),
        ),
      ],
    );
  }

  /// Builds a navigation button with the specified icon.
  Widget _navigationButton(IconData icon) {
    return Container(
      width: 62.sp,
      height: 62.sp,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: AppColors.whiteColor, size: 24.sp),
    );
  }

  /// Builds the dots indicator for the screens.
  Widget _buildDotsIndicator(int currentIndex, int totalScreens) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalScreens, (index) {
        return Container(
          width: 10.sp,
          height: currentIndex == index ? 14.sp : 4.sp,
          margin: EdgeInsets.only(right: 4.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(56.sp),
            color: AppColors.primaryColor
                .withOpacity(currentIndex == index ? 1 : 0.4),
          ),
        );
      }),
    );
  }
}
