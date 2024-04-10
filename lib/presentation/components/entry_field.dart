import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class EntryField extends StatelessWidget {
  final String? hintText;
  final String? initialValue;
  final EdgeInsetsGeometry? margin;
  final TextEditingController? texteditcontroller;
  final Icon? icon;
  const EntryField(
      {Key? key,
      this.hintText,
      this.margin,
      this.initialValue,
      this.texteditcontroller,
      this.icon,
      String? Function(String? text)? validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: texteditcontroller,
        initialValue: initialValue,
        style: FxTextStyle.bodyMedium(),
        decoration: InputDecoration(
            icon: icon,
            hintText: hintText,
            enabledBorder: InputBorder.none,
            hintStyle: TextStyle(color: theme.hintColor, fontSize: 14)),
      ),
    );
  }
}
