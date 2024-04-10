import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  final IconData? icon;

  const IconContainer({Key? key, this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: theme.primaryColor,
      ),
      child: Icon(
        icon,
        size: 20,
        color: theme.colorScheme.background,
      ),
    );
  }
}
