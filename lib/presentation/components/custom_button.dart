import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../themes/theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  final Function? onTap;
  final String? text;
  final BorderRadius? borderRadius;
  final EdgeInsets? margin;
  final bool loading;
  const CustomButton(
      {Key? key,
      this.onTap,
      this.text,
      this.borderRadius,
      this.margin,
      required this.loading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = AppTheme.shoppingLightTheme;

    return GestureDetector(
      onTap: loading
          ? null
          : onTap as void Function()? ??
              () {
                Navigator.pop(context);
              },
      child: FadedScaleAnimation(
        child: Container(
          padding: const EdgeInsets.all(16),
          margin:
              margin ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
          decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: borderRadius ?? BorderRadius.circular(8)),
          child: loading
              ? const Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
                )
              : FxText.bodyLarge(
                  text ?? "Aceptar",
                  textAlign: TextAlign.center,
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}
