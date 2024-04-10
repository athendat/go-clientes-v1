import 'package:flutter/material.dart';

class EntryFieldSecond extends StatelessWidget {
  final String? label;
  final String? initialValue;
  final Icon? suffixIcon;
  final EdgeInsets? margin;
  const EntryFieldSecond(
      {Key? key, this.label, this.initialValue, this.suffixIcon, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: theme.colorScheme.background,
      ),
      child: TextFormField(
        initialValue: initialValue,
        style: Theme.of(context).textTheme.titleMedium,
        decoration: InputDecoration(
            labelText: label,
            contentPadding: const EdgeInsets.all(8),
            suffixIcon: suffixIcon ?? const SizedBox.shrink()),
      ),
    );
  }
}
