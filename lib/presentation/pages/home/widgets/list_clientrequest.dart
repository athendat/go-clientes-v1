import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';
import 'package:client.gogogo/presentation/components/loading_effect.dart';
import 'package:client.gogogo/presentation/pages/home/controller/home_controller.dart';

import '../../request/screen/request_page.dart';

class Tasks {
  final String truckImage;
  final String truckName;
  final String? type;
  final String? typeOfDelivery;
  final String departedTime;
  final String location;

  Tasks(this.truckImage, this.truckName, this.type, this.typeOfDelivery,
      this.departedTime, this.location);
}

class ListClientRequest extends StatelessWidget {
  const ListClientRequest({
    super.key,
    required this.tasks,
    required this.theme,
    required this.controller,
  });

  final List<dynamic> tasks;
  final ThemeData theme;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: FxSpacing.only(bottom: 20),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          var loaodingIncrement = false.obs;
          return GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: theme.colorScheme.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  FxContainer(
                    // color: theme.dialogBackgroundColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    height: 48,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.asset(
                            "assets/img/png/truck.jpg",
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        FxText.bodySmall(
                          tasks[index]["status"].toUpperCase() == "ACEPTADA"
                              ? "Transportista:  -- --"
                              : "",
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        FxText.bodySmall(
                          '',
                        ),
                        const Spacer(),
                        FxText.bodyMedium(tasks[index]["status"].toUpperCase(),
                            fontWeight: 800,
                            color: tasks[index]["status"] == "entregada"
                                ? Colors.green
                                : tasks[index]["status"] == "asignada"
                                    ? Colors.blue
                                    : tasks[index]["status"] == "lista"
                                        ? theme.colorScheme.primary
                                        : tasks[index]["status"] == "aceptada"
                                            ? Colors.green
                                            : tasks[index]["status"] ==
                                                    "transportando"
                                                ? Colors.amber
                                                : tasks[index]["status"] ==
                                                        "rechazada"
                                                    ? Colors.red[700]
                                                    : Colors.green),
                        const SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    dense: true,
                    title: FxText.bodySmall(
                      '#Seguimiento',
                    ),
                    subtitle: FxText.bodySmall(
                      tasks[index]["tracking"].toString(),
                      fontWeight: 300,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FxText.bodySmall(
                              'Estado del Pago',
                            ),
                            FxContainer(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 5),
                              margin: FxSpacing.zero,
                              borderRadiusAll: 8,
                              color: theme.primaryColor,
                              child: FxText.bodySmall(
                                tasks[index]["paymentStatus"],
                                color:
                                    tasks[index]["paymentStatus"] == "pendiente"
                                        ? theme.cardColor
                                        : Colors.green,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    dense: true,
                    title: FxText.bodySmall(
                      'Fecha de Recogida',
                    ),
                    subtitle: FxText.bodySmall(
                      controller.f.format(
                        controller.getdaterequest(tasks[index]),
                      ),
                      fontWeight: 300,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                              padding: FxSpacing.zero,
                              icon:Icon(Icons.request_quote,
                                      color: theme.colorScheme.primary,
                                      size: 25,
                                    ),
                                    onPressed: (){controller.goToOffers(tasks[index]["id"],tasks[index]["tracking"]);},
                                    ),
                        
                        Builder(
                          builder: (context) => Obx(() => IconButton(
                              padding: FxSpacing.zero,
                              icon: loaodingIncrement.value
                                  ? const SizedBox(
                                      height: 10,
                                      width: 10,
                                      child: Center(
                                          child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      )),
                                    )
                                  : 
                                    Icon(
                                      tasks[index]["status"] != "nueva"
                                          ? Icons.remove_red_eye_rounded
                                          : Icons.edit_rounded,
                                      color: theme.colorScheme.primary,
                                      size: 25,
                                    ),
                              onPressed: () async {
                                Navigator.of(context, rootNavigator: true).push(
                                    PageRouteBuilder(
                                        transitionDuration:
                                            const Duration(seconds: 0),
                                        pageBuilder: (_, __, ___) =>
                                            RequestPage(
                                                edit: true,
                                                solicitud: tasks[index])));
                              })),
                        ),
                        Visibility(
                          visible: tasks[index]["status"] == "asignada",
                          child: Builder(
                            builder: (context) => Obx(() => IconButton(
                                padding: FxSpacing.zero,
                                icon: loaodingIncrement.value
                                    ? const SizedBox(
                                        height: 10,
                                        width: 10,
                                        child: Center(
                                            child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        )),
                                      )
                                    : Icon(
                                        Icons.check_circle_rounded,
                                        color: theme.colorScheme.primary,
                                        size: 25,
                                      ),
                                onPressed: () async {
                                  loaodingIncrement.value = true;
                                  showDialogrequestReady(
                                      context, tasks[index]['id']);
                                  //  await controller
                                  //      .requestmarkLista(tasks[index]['id']);
                                  loaodingIncrement.value = false;
                                })),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FxSpacing.height(5),
                ],
              ),
            ),
          );
        });
  }

  showDialogrequestReady(
    context,
    String id,
  ) {
    var loadingready = false.obs;
    return showDialog<void>(
      context: controller.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: FxSpacing.only(left: 16, right: 16),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: FxSpacing.only(bottom: 16),
          title: Center(
            child: FxText.titleMedium("Marcar solicitud como Lista",
                height: 1.2, fontWeight: 600),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FxSpacing.height(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //padding: const EdgeInsets.only(left: 16.0, top: 15),
                  FxText.bodyLarge("Observaciones", fontWeight: 450),
                ],
              ),
              TextFormField(
                style: FxTextStyle.bodyMedium(
                    color: theme.colorScheme.onBackground.withAlpha(130),
                    fontWeight: 600,
                    letterSpacing: 0.2),
                decoration: InputDecoration(
                  hintStyle: FxTextStyle.bodyLarge(
                      fontWeight: 500,
                      letterSpacing: 0,
                      color: theme.colorScheme.onBackground.withAlpha(70)),
                  hintText: "",
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: FxSpacing.zero,
                ),
                autofocus: false,
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                controller: controller.obsLista,
              ),
              Container(
                height: 0.5,
                color: theme.hintColor,
                margin: const EdgeInsets.only(left: 0),
              ),
              FxSpacing.height(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme
                          .background, // Cambia el color de fondo aquí
                      // Otros ajustes de estilo, como padding, textStyle, etc.
                    ),
                    child: FxText.titleMedium('Cancelar',
                        color: theme.colorScheme.primary,
                        fontWeight: 600,
                        letterSpacing: 0.3),
                    onPressed: () async {
                      controller.obsLista.text = "";
                      Navigator.pop(context);
                      ;
                    },
                  ),
                  Obx(() => ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                theme.colorScheme.primary)),
                        child: loadingready.value
                            ? SizedBox(
                                height: 10,
                                width: 10,
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: theme.colorScheme.background,
                                  strokeWidth: 2,
                                )),
                              )
                            : FxText.titleMedium("Aceptar",
                                color: theme.colorScheme.background,
                                fontWeight: 600,
                                letterSpacing: 0.3),
                        onPressed: () async {
                          loadingready.value = true;
                          var can = await controller.requestmarkLista(id);
                          can
                              ? {
                                  Navigator.pop(
                                      context, controller.obsLista.text = "")
                                }
                              : null;
                          loadingready.value = false;
                        },
                      )),
                ],
              ),
            ],
          ),
          actions: <Widget>[],
        );
      },
    );
  }
}
