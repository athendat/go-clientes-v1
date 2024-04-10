import 'package:flutter/material.dart';

class LineContainer extends StatelessWidget {
  const LineContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      height: 0.5,
      color: theme.hintColor,
      margin: const EdgeInsets.only(left: 16),
    );
  }
}
