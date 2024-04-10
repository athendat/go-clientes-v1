import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class CustomListTile extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  const CustomListTile(
      {Key? key,
      required this.title,
      required this.subtitle,
      this.leading,
      this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: FxText.bodyLarge(
        title!,
      ),
      subtitle: FxText.bodyMedium(
        subtitle!,
        color: Colors.black45,
      ),
      trailing: trailing,
    );
  }
}
