import 'package:flutter/material.dart';
import 'package:client.gogogo/presentation/themes/colors.dart';

final ThemeData appTheme = ThemeData(
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
        fontFamily: 'Oswald'),
    displayMedium: const TextStyle(),
    titleMedium: const TextStyle(),
    titleSmall: TextStyle(color: darkHintColor),
    headlineSmall: const TextStyle(color: Colors.white, fontSize: 20),
    titleLarge: const TextStyle(color: Colors.white, fontSize: 16),
    bodyMedium: const TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: darkHintColor),
  ),
  colorScheme: ColorScheme.fromSwatch(
    backgroundColor: Colors.white,
  ),
);

/// NAME         SIZE  WEIGHT  SPACING
/// headline1    96.0  light   -1.5
/// displayMedium    60.0  light   -0.5
/// headline3    48.0  regular  0.0
/// headline4    34.0  regular  0.25
/// headlineSmall    24.0  regular  0.0
/// titleLarge    20.0  medium   0.15
/// subtitle1    16.0  regular  0.15
/// titleSmall    14.0  medium   0.1
/// body1        16.0  regular  0.5   (bodyLarge)
/// body2        14.0  regular  0.25  (bodyText2)
/// button       14.0  medium   1.25
/// caption      12.0  regular  0.4
/// overline     10.0  regular  1.5
