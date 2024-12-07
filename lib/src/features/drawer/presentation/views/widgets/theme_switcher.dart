part of 'package:emdr_mindmend/src/features/drawer/presentation/views/drawer_screen.dart';

class _ThemeSwitcher extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access the current color mode
    final colorMode = ref.watch(colorModeProvider);

    return SwitchListTile(
      title: Text(
        'Dark Mode',
        style: TextStyle(
          color: AppColorHelper.getPrimaryTextColor(colorMode),
        ),
      ),
      value: colorMode == ColorMode.dark,
      onChanged: (isDarkMode) {
        // Toggle the color mode
        ref.read(colorModeProvider.notifier).toggleColorMode();
      },
      activeColor: AppColors.primaryColor,
      inactiveThumbColor: AppColors.lightSecondaryTextColor,
      inactiveTrackColor: AppColors.lightScaffoldColor,
    );
  }
}
