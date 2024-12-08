import 'package:emdr_mindmend/src/core/constants/colors.dart';
import 'package:emdr_mindmend/src/core/enums/color_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ColorModeNotifier extends StateNotifier<ColorMode> {
  ColorModeNotifier() : super(ColorMode.light);

  void toggleColorMode() {
    state = state == ColorMode.light ? ColorMode.dark : ColorMode.light;
  }
}

final colorModeProvider =
    StateNotifierProvider<ColorModeNotifier, ColorMode>((ref) {
  return ColorModeNotifier();
});

class AppColorHelper {
  static Color getPrimaryColor(ColorMode mode) {
    return mode == ColorMode.light
        ? AppColors.primaryColor
        : AppColors.primaryColor;
  }

  static Color getScaffoldColor(ColorMode mode) {
    return mode == ColorMode.light
        ? AppColors.lightScaffoldColor
        : AppColors.darkScaffoldColor;
  }

  static Color getPrimaryTextColor(ColorMode mode) {
    return mode == ColorMode.light
        ? AppColors.lightPrimaryTextColor
        : AppColors.darkPrimaryTextColor;
  }

  static Color getSecondaryTextColor(ColorMode mode) {
    return mode == ColorMode.light
        ? AppColors.lightSecondaryTextColor
        : AppColors.darkSecondaryTextColor;
  }

  static Color getTertiaryTextColor(ColorMode mode) {
    return mode == ColorMode.light ? AppColors.greyColor : AppColors.whiteColor;
  }

  static Color getIconColor(ColorMode mode) {
    return mode == ColorMode.light
        ? AppColors.lightSecondaryTextColor
        : AppColors.lightCardColor;
  }

  static Color cardColor(ColorMode mode) {
    return mode == ColorMode.light
        ? AppColors.lightCardColor
        : AppColors.darkCardColor;
  }

  static Color dividerColor(ColorMode mode) {
    return mode == ColorMode.light
        ? AppColors.borderColor
        : AppColors.lightCardColor;
  }

  static Color hintColor(ColorMode mode) {
    return mode == ColorMode.light
        ? AppColors.hintColor
        : AppColors.darkSecondaryTextColor;
  }
}
