part of 'package:emdr_mindmend/src/features/dashboard/presentation/views/dashboard_screen/dashboard_screen.dart';

class _CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const _CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: AppColors.scaffoldColor,
      color: AppColors.primaryDarkColor,
      animationDuration: const Duration(milliseconds: 300),
      items: _buildNavigationBarItems(),
      onTap:
          onItemSelected, // Trigger callback directly when the animation completes
    );
  }

  List<Widget> _buildNavigationBarItems() {
    const icons = [
      AppImages.home,
      AppImages.info,
      AppImages.dashboardMainIconUnselected,
      AppImages.setting,
      AppImages.profile,
    ];

    return List.generate(
      icons.length,
      (index) => _buildNavItem(
        assetPath: icons[index],
        isSelected: index == selectedIndex,
      ),
    );
  }

  Widget _buildNavItem({required String assetPath, required bool isSelected}) {
    final bool isDashboardIcon =
        assetPath == AppImages.dashboardMainIconUnselected;

    return Container(
      decoration: isSelected
          ? const BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            )
          : null,
      padding: isSelected ? const EdgeInsets.all(8.0) : EdgeInsets.zero,
      child: Image.asset(
        isDashboardIcon && isSelected
            ? AppImages.dashboardMainIconSelected
            : assetPath,
        width: 30,
        height: 30,
        color: isDashboardIcon
            ? null
            : (isSelected ? Colors.white : const Color(0xff68937E)),
        fit: BoxFit.contain,
      ),
    );
  }
}
