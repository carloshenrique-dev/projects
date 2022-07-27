import 'package:flutter/material.dart';
import 'styles/app_colors.dart';
import 'styles/app_text_styles.dart';

abstract class Themes {
  static final lightTheme = ThemeData(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.whiteDefault,
      unselectedItemColor: AppColors.whiteDefault,
      selectedIconTheme: const IconThemeData(
        color: AppColors.defaultGreen,
      ),
      unselectedIconTheme: const IconThemeData(
        color: AppColors.whiteDefault,
      ),
      type: BottomNavigationBarType.shifting,
      selectedLabelStyle: AppTextStyles.labelBottomNavigationDark,
    ),
    brightness: Brightness.light,
    unselectedWidgetColor: AppColors.whiteDefault,
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: AppColors.waterGreen),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: AppColors.waterGreen,
        ),
      ),
    ),
  );

  static final darktheme = ThemeData(
    dividerColor: Colors.transparent,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.grayColor,
      unselectedItemColor: AppColors.grayColor,
      selectedIconTheme: const IconThemeData(
        color: AppColors.defaultGreen,
      ),
      unselectedIconTheme: const IconThemeData(
        color: AppColors.grayColor,
      ),
      type: BottomNavigationBarType.shifting,
      selectedLabelStyle: AppTextStyles.labelBottomNavigationWhite,
    ),
    brightness: Brightness.dark,
    unselectedWidgetColor: AppColors.whiteDefault,
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: AppColors.waterGreen),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: AppColors.waterGreen,
        ),
      ),
    ),
  );
}
