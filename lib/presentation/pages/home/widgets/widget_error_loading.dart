import 'package:client.gogogo/presentation/pages/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';

class WidgetErrorLoading extends StatefulWidget {
  final HomeController controller;
  const WidgetErrorLoading(this.controller, {super.key});

  @override
  State<WidgetErrorLoading> createState() => _WidgetErrorLoadingState();
}

class _WidgetErrorLoadingState extends State<WidgetErrorLoading> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: FxSpacing.only(top: (Get.height - 240) / 2),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: FxText.bodyLarge(
              "¡Ha ocurrido un error inesperado!",
              fontWeight: 300,
              color: theme.colorScheme.background,
            ),
          ),
          FxText.bodyLarge(
            "Reintentar",
            fontWeight: 500,
            color: theme.colorScheme.background,
          ),
          IconButton(
              onPressed: () async {
                await widget.controller.getrequests();
              },
              icon: Icon(
                Icons.refresh_rounded,
                color: theme.colorScheme.background,
              ))
        ],
      ),
    );
  }
}
