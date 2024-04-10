import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../../presentation/themes/theme/app_theme.dart';

class Info {
  static message(String message,
      {GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey,
      BuildContext? context,
      Duration? duration,
      SnackBarBehavior snackBarBehavior = SnackBarBehavior.fixed}) {
    duration ??= const Duration(seconds: 3);
    ThemeData theme = AppTheme.shoppingTheme;

    SnackBar snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 60),
      elevation: 2,
      duration: duration,
      content: FxText(
        message,
        color: theme.colorScheme.onPrimary,
      ),
      backgroundColor: theme.colorScheme.primary,
    );

    if (scaffoldMessengerKey != null) {
      scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
    } else if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {}
  }

  static error(String message,
      {GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey,
      BuildContext? context,
      Duration? duration,
      SnackBarBehavior snackBarBehavior = SnackBarBehavior.fixed}) {
    duration ??= const Duration(seconds: 3);
    ThemeData theme = AppTheme.theme;

    SnackBar snackBar = SnackBar(
      duration: duration,
      content: FxText(
        message,
        color: theme.colorScheme.onError,
      ),
      backgroundColor: theme.colorScheme.error,
      behavior: snackBarBehavior,
    );

    if (scaffoldMessengerKey != null) {
      scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
    } else if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {}
  }
}
