import 'package:client.gogogo/presentation/pages/home/controller/home_controller.dart';
import 'package:client.gogogo/presentation/pages/offers/controller/offers_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';

class WidgetErrorLoading extends StatefulWidget {
  final OffersController controller;
  const WidgetErrorLoading(this.controller, {super.key});

  @override
  State<WidgetErrorLoading> createState() => _WidgetErrorLoadingState();
}

class _WidgetErrorLoadingState extends State<WidgetErrorLoading> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                await widget.controller.getBids();
              },
              icon: Icon(
                Icons.refresh_rounded,
                color: theme.colorScheme.background,
              ))
        ],
    );
  }
}
