part of 'package:emdr_mindmend/src/features/dashboard/presentation/views/dashboard_screen/dashboard_screen.dart';

class _BottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const _BottomNavigationBar({
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        BottomSheetContent(
          selectedIndex: selectedIndex,
          onItemSelected: onItemSelected,
        ),
        Positioned(
          top: -25.sp,
          child: GestureDetector(
            onTap: () => onItemSelected(2),
            child: Container(
              width: 56.sp,
              height: 56.sp,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
                border:
                    Border.all(color: AppColors.darkScaffoldColor, width: 4),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.sp),
                child: Image.asset(
                  AppImages.dashboardMainIconSelected,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BottomSheetContent extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const BottomSheetContent({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final icons = [
      AppImages.home,
      AppImages.info,
      AppImages.dashboardMainIconSelected,
      AppImages.setting,
      AppImages.profile,
    ];
    final padding = MediaQuery.of(context).padding;
    return Container(
      padding: EdgeInsets.only(top: 16.sp,bottom: 12.sp).add(padding),
      decoration: const BoxDecoration(color: AppColors.darkCardColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(icons.length, (index) {
          if (index == 2) {
            return const Spacer(); // Space for the center icon
          }
          return Expanded(
            child: GestureDetector(
              onTap: () => onItemSelected(index),
              child: Image.asset(
                icons[index],
                color: selectedIndex == index
                    ? Colors.white
                    : const Color(0xff68937E),
                width: 28.sp,
                height: 28.sp,
              ),
            ),
          );
        }),
      ),
    );
  }
}
