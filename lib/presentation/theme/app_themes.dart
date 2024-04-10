import 'package:flutter/material.dart';
import '../themes/colors.dart';
import 'app_bar_theme.dart';
import 'app_button_themes.dart';
import 'app_colors.dart';
import 'app_elevated_button_themes.dart';
import 'app_floating_button_themes.dart';
import 'app_switch_themes.dart';

class AppThemes {
  static ThemeData light = ThemeData(
    fontFamily: 'Oswald',
    useMaterial3: true,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: AppColors.gold),
    appBarTheme: AppBarThemes.light,
    scaffoldBackgroundColor: AppColors.gold.shade50,
    buttonTheme: AppButtonThemes.light,
    elevatedButtonTheme: AppElevatedButtonThemes.light,
    switchTheme: AppSwitchThemes.light,
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(primary: AppColors.sea),
    appBarTheme: AppBarThemes.dark,
    scaffoldBackgroundColor: AppColors.sea.shade900.withAlpha(100),
    floatingActionButtonTheme: AppFloatingButtonThemes.dark,
    switchTheme: AppSwitchThemes.dark,
  );

  static ThemeData light2 = ThemeData(
    useMaterial3: true,
    fontFamily: 'Oswald',
    scaffoldBackgroundColor: const Color(0xff1c2025),
    hintColor: const Color(0xffCDCDCD),
    primaryColor: const Color(0xffE6B54A),
    secondaryHeaderColor: const Color(0xff343b45),
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white)),
    textTheme: TextTheme(
      bodyLarge: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        letterSpacing: 0,
        fontFamily: 'Oswald',
      ),
      displayMedium: const TextStyle(
        fontFamily: 'Oswald',
      ),
      titleMedium: const TextStyle(
        fontFamily: 'Oswald',
      ),
      titleSmall: TextStyle(
        color: darkHintColor,
        fontFamily: 'Oswald',
      ),
      headlineSmall: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: 'Oswald',
      ),
      titleLarge: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontFamily: 'Oswald',
      ),
      bodyMedium: const TextStyle(
        color: Colors.white,
        fontFamily: 'Oswald',
      ),
      bodySmall: TextStyle(
        color: darkHintColor,
        fontFamily: 'Oswald',
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(
      backgroundColor: Colors.white,
    ),
  );
}
