import 'package:client.gogogo/presentation/pages/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:client.gogogo/presentation/themes/colors.dart';
import 'package:client.gogogo/presentation/themes/theme/app_theme.dart';

class StatusOfDelivery extends StatefulWidget {
  final HomeController controller;
  const StatusOfDelivery({required this.controller, Key? key})
      : super(key: key);

  @override
  _StatusOfDeliveryState createState() => _StatusOfDeliveryState();
}

class _StatusOfDeliveryState extends State<StatusOfDelivery> {
  late ThemeData theme;
  List<bool> isSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  @override
  Widget build(BuildContext context) {
    theme = AppTheme.shoppingLightTheme;

    List<String> types = [
      "Nueva",
      "Aprobada",
      "Aceptada",
      "Asignada",
      "Lista",
      "Cancelada",
      "Rechazada",
      "Transportando",
      "Entregada"
    ];

    return SizedBox(
      height: 50,
      child: ListView.builder(
          itemCount: types.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (!widget.controller.loadrequest.value) {
                    isSelected[index] = !isSelected[index];
                    isSelected[index] == true
                        ? widget.controller.statusfilter
                            .add(types[index].toLowerCase())
                        : widget.controller.statusfilter.removeWhere(
                            (elemento) =>
                                elemento == types[index].toLowerCase());
                  }
                });

                widget.controller.getrequests();
              },
              child: Container(
                margin: const EdgeInsets.all(8),
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                    color: isSelected[index]
                        ? theme.primaryColor
                        : theme.appBarTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(24)),
                child: FxText.bodySmall(types[index],
                    color: isSelected[index]
                        ? theme.colorScheme.background
                        : darkHintColor),
              ),
            );
          }),
    );
  }
}
