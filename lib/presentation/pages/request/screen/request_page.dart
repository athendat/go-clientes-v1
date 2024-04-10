import 'dart:async';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:client.gogogo/presentation/pages/request/widgets/widget_error_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:client.gogogo/core/helpers/environment.dart';
import 'package:client.gogogo/presentation/components/loading_effect.dart';
import 'package:client.gogogo/presentation/pages/home/screen/home_page.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_list_tile.dart';
import '../../../components/line_container.dart';
import '../../../themes/theme/app_theme.dart';
import '../controller/request_controller.dart';

class RequestPage extends StatefulWidget {
  final bool edit;
  final dynamic solicitud;
  const RequestPage({Key? key, required this.edit, this.solicitud})
      : super(key: key);

  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage>
    with TickerProviderStateMixin {
  late ThemeData theme;
  late RequestController controller;
  late MapboxMapController mapcontroller;

  final List<AnnotationType> annotationorder = [
    AnnotationType.line,
    AnnotationType.fill,
    AnnotationType.circle,
    AnnotationType.symbol,
  ];
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  void initState() {
    theme = AppTheme.shoppingLightTheme;
    controller = FxControllerStore.put(
        RequestController(this, widget.edit, widget.solicitud));

    super.initState();
  }

  @override
  void dispose() {
    // mapcontroller.dispose(); // Cancela la suscripción al stream
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<RequestController>(
        controller: controller,
        builder: (controller) {
          return Scaffold(
            // key: _drawerKey,

            appBar: appbar(),
            body: Obx(() => controller.loadinggetrequest.value
                ? FadedScaleAnimation(
                    child: LoadingEffect.getReviewLoadingScreen(context))
                : controller.exeption.value
                    ? WidgetErrorLoading(controller)
                    : bodyrequest(
                        controller, context, controller.initialCameraPosition)),
          );
        });
  }

  Stack bodyrequest(RequestController controller, BuildContext context,
      CameraPosition initialCameraPosition) {
    return Stack(
      children: [
        Container(
          color: theme.dividerColor,
        ),
        Form(
          key: controller.formKey,
          child: ListView(
            padding: FxSpacing.all(10),
            children: [
              widget.edit
                  ? FadedScaleAnimation(
                      child: Container(
                        padding: const EdgeInsets.only(
                            right: 16, left: 16, bottom: 10, top: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: controller.status.value == "entregada"
                                ? Colors.green.withAlpha(50)
                                : controller.status.value == "asignada"
                                    ? Colors.blue.withAlpha(50)
                                    : controller.status.value == "lista"
                                        ? theme.colorScheme.primary
                                            .withAlpha(50)
                                        : controller.status.value == "aceptada"
                                            ? Colors.green.withAlpha(50)
                                            : controller.status.value ==
                                                    "transportando"
                                                ? Colors.amber.withAlpha(50)
                                                : controller.status.value ==
                                                        "rechazada"
                                                    ? Colors.red.withAlpha(50)
                                                    : Colors.green
                                                        .withAlpha(50)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FxText.bodyMedium(
                                controller.status.value.toUpperCase(),
                                fontWeight: 800,
                                color: controller.status.value == "entregada"
                                    ? Colors.green
                                    : controller.status.value == "asignada"
                                        ? Colors.blue
                                        : controller.status.value == "lista"
                                            ? theme.colorScheme.primary
                                            : controller.status.value ==
                                                    "aceptada"
                                                ? Colors.green
                                                : controller.status.value ==
                                                        "transportando"
                                                    ? Colors.amber
                                                    : controller.status.value ==
                                                            "rechazada"
                                                        ? Colors.red[700]
                                                        : Colors.green),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              Obx(() => Visibility(
                    visible: controller.distance != "",
                    child: FxSpacing.height(10),
                  )),
              Visibility(
                visible: controller.distance != "",
                child: FadedScaleAnimation(
                  child: Container(
                    padding: const EdgeInsets.only(
                        right: 16, left: 16, bottom: 0, top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: theme.colorScheme.background,
                    ),
                    child: Row(
                      children: [
                        Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RotatedBox(
                                quarterTurns: 1,
                                child: Text(' ------- ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(height: 1.1))),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              CustomListTile(
                                  title: "Distancia",
                                  subtitle:
                                      '${controller.distance.value.toString()} Km'),
                            ],
                          ),
                        ),
                        Obx(() => Expanded(
                              child: Column(
                                children: [
                                  CustomListTile(
                                      title: "Costo de solicitud",
                                      subtitle:
                                          '${!controller.changefeeview.value && widget.edit ? controller.costo.value.toString() : num.parse(controller.distance.value) * controller.feeupdate.value} cup'),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              FxSpacing.height(10),
              Visibility(
                visible: true,
                child: FadedScaleAnimation(
                  child: FxContainer.bordered(
                    onTap: () {
                      _showBottomSheet(context);
                    },
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    borderRadius: BorderRadius.circular(12),
                    color: theme.colorScheme.background,
                    child: Row(
                      children: [
                        Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 6,
                              backgroundColor: theme.primaryColor,
                            ),
                            RotatedBox(
                                quarterTurns: 1,
                                child: Text(' ---------- ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(height: 1.1))),
                            const CircleAvatar(
                              radius: 6,
                              backgroundColor: Colors.red,
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomListTile(
                                        title: "Origen",
                                        subtitle: controller.geoorigin.value),
                                  ),
                                ],
                              ),
                              Container(
                                height: 0.5,
                                color: theme.hintColor,
                                margin: const EdgeInsets.only(left: 16),
                              ),
                              CustomListTile(
                                  title: "Destino",
                                  subtitle: controller.geodestiny.value),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              FxSpacing.height(10),
              Material(
                elevation: 2.5,
                shadowColor: theme.primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(20),
                child: FxContainer.bordered(
                  color: theme.colorScheme.background,
                  padding: FxSpacing.only(right: 15),
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Visibility(
                        visible: widget.edit,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, top: 15),
                              child: FxText.bodyLarge("Número de Solicitud"),
                            ),
                            Row(children: [
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, top: 10, bottom: 15),
                                child: FxText.bodyMedium(
                                    widget.edit
                                        ? widget.solicitud['tracking']
                                        : "",
                                    fontWeight: 500,
                                    letterSpacing: 0,
                                    color: theme.colorScheme.onBackground
                                        .withAlpha(130)),
                              ))
                            ]),
                            const LineContainer(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 15),
                        child: FxText.bodyLarge("Título *"),
                      ),
                      TextFormField(
                        style: FxTextStyle.bodyMedium(
                            color:
                                theme.colorScheme.onBackground.withAlpha(130),
                            fontWeight: 600,
                            letterSpacing: 0.2),
                        decoration: InputDecoration(
                          hintStyle: FxTextStyle.bodyLarge(
                              fontWeight: 500,
                              letterSpacing: 0,
                              color:
                                  theme.colorScheme.onBackground.withAlpha(70)),
                          hintText: "",
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          isDense: true,
                          enabled: controller.readonly.value,
                          contentPadding: const EdgeInsets.only(
                              left: 16, top: 2, bottom: 16),
                        ),
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        controller: controller.title,
                        validator: controller.validateText,
                      ),
                      const LineContainer(),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, top: 15),
                                  child:
                                      FxText.bodyLarge("Cantidad de paquetes"),
                                ),
                                TextFormField(
                                  style: FxTextStyle.bodyMedium(
                                      color: theme.colorScheme.onBackground
                                          .withAlpha(130),
                                      fontWeight: 600,
                                      letterSpacing: 0.2),
                                  decoration: InputDecoration(
                                    hintStyle: FxTextStyle.bodyLarge(
                                        fontWeight: 500,
                                        letterSpacing: 0,
                                        color: theme.colorScheme.onBackground
                                            .withAlpha(70)),
                                    hintText: "",
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    isDense: true,
                                    enabled: controller.readonly.value,
                                    contentPadding: const EdgeInsets.only(
                                        left: 16, top: 2, bottom: 16),
                                  ),
                                  autofocus: false,
                                  keyboardType: TextInputType.number,
                                  controller: controller.cantpaqt,
                                  // validator: controller.validateText,
                                ),
                                const LineContainer(),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, top: 16),
                                  child:
                                      FxText.bodyLarge("Fecha de recogida *"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, bottom: 17),
                                  child: GestureDetector(
                                    onTap: () async {
                                      return controller.readonly.value
                                          ? await showDatePicker(
                                              context: context,
                                              firstDate: DateTime.now(),
                                              initialDate: DateTime.now(),
                                              lastDate: DateTime(2100),
                                            ).then((DateTime? date) async {
                                              if (date != null) {
                                                final time =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime:
                                                      TimeOfDay.fromDateTime(
                                                          DateTime.now()),
                                                );

                                                date = DateTime(
                                                        date.year,
                                                        date.month,
                                                        date.day,
                                                        time?.hour ?? 0,
                                                        time?.minute ?? 0)
                                                    .toUtc();

                                                controller.daterecogida.value =
                                                    date.toLocal();
                                                controller.daterecogidaUtc
                                                    .value = date;
                                                //  // print(date.toIso8601String());
                                              } else {
                                                //   return currentValue;
                                              }
                                            })
                                          : null;
                                    },
                                    child: Obx(() => FxText.bodyMedium(
                                        controller.f.format(
                                            controller.daterecogida.value),
                                        color: theme.colorScheme.onBackground
                                            .withAlpha(130),
                                        fontWeight: 500,
                                        letterSpacing: 0.2)),
                                  ),
                                ),
                                const LineContainer(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, top: 15),
                                  child: FxText.bodyLarge("Peso"),
                                ),
                                TextFormField(
                                  style: FxTextStyle.bodyMedium(
                                      color: theme.colorScheme.onBackground
                                          .withAlpha(130),
                                      fontWeight: 600,
                                      letterSpacing: 0.2),
                                  decoration: InputDecoration(
                                    hintStyle: FxTextStyle.bodyLarge(
                                        fontWeight: 500,
                                        letterSpacing: 0,
                                        color: theme.colorScheme.onBackground
                                            .withAlpha(70)),
                                    hintText: "",
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(
                                        left: 16, top: 2, bottom: 16),
                                  ),
                                  autofocus: false,
                                  enabled: controller.readonly.value,
                                  keyboardType: TextInputType.number,
                                  controller: controller.peso,
                                  //  validator: controller.validateText,
                                ),
                                const LineContainer(),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, top: 15),
                                  child: FxText.bodyLarge("Volumen"),
                                ),
                                TextFormField(
                                  style: FxTextStyle.bodyMedium(
                                      color: theme.colorScheme.onBackground
                                          .withAlpha(130),
                                      fontWeight: 600,
                                      letterSpacing: 0.2),
                                  decoration: InputDecoration(
                                    hintStyle: FxTextStyle.bodyLarge(
                                        fontWeight: 500,
                                        letterSpacing: 0,
                                        color: theme.colorScheme.onBackground
                                            .withAlpha(70)),
                                    hintText: "",
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    isDense: true,
                                    contentPadding: const EdgeInsets.only(
                                        left: 16, top: 2, bottom: 16),
                                  ),
                                  autofocus: false,
                                  enabled: controller.readonly.value,
                                  keyboardType: TextInputType.number,
                                  controller: controller.volumen,
                                  // validator: controller.validateText,
                                ),
                                const LineContainer(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      /*   Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, top: 15),
                                  child: FxText.bodyLarge("Valor de carga"),
                                ),
                                TextFormField(
                                  style: FxTextStyle.bodyMedium(
                                      color: theme.colorScheme.onBackground
                                          .withAlpha(130),
                                      fontWeight: 600,
                                      letterSpacing: 0.2),
                                  decoration: InputDecoration(
                                    hintStyle: FxTextStyle.bodyLarge(
                                        fontWeight: 500,
                                        letterSpacing: 0,
                                        color: theme.colorScheme.onBackground
                                            .withAlpha(70)),
                                    hintText: "20000cup",
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    isDense: true,
                                    enabled: controller.readonly.value,
                                    contentPadding: const EdgeInsets.only(
                                        left: 16, top: 2, bottom: 16),
                                  ),
                                  autofocus: false,
                                  keyboardType: TextInputType.text,
                                  controller: controller.valorcarga,
                                  validator: controller.validateText,
                                ),
                                const LineContainer(),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16.0, top: 9),
                                        child: FxText.bodyLarge("Imo"),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: Obx(() => Switch(
                                            activeColor: theme.primaryColor,
                                            activeTrackColor: theme.primaryColor
                                                .withAlpha(60),
                                            value: controller.isImo.value,
                                            onChanged: (value) {
                                              controller.readonly.value
                                                  ? controller.isImo.value =
                                                      value
                                                  : null;
                                            })),
                                      ),
                                      const LineContainer(),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16.0, top: 9),
                                        child: FxText.bodyLarge("Refrigerado"),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: Obx(() => Switch(
                                            activeColor: theme.primaryColor,
                                            activeTrackColor: theme.primaryColor
                                                .withAlpha(60),
                                            value: controller.isRef.value,
                                            onChanged: (value) {
                                              controller.readonly.value
                                                  ? controller.isRef.value =
                                                      value
                                                  : null;
                                            })),
                                      ),
                                      const LineContainer(),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),*/
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 15),
                        child: FxText.bodyLarge("Dirección Origen *"),
                      ),
                      TextFormField(
                        style: FxTextStyle.bodyMedium(
                            color:
                                theme.colorScheme.onBackground.withAlpha(130),
                            fontWeight: 600,
                            letterSpacing: 0.2),
                        decoration: InputDecoration(
                          hintStyle: FxTextStyle.bodyLarge(
                              fontWeight: 500,
                              letterSpacing: 0,
                              color:
                                  theme.colorScheme.onBackground.withAlpha(70)),
                          hintText: "",
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          isDense: true,
                          enabled: controller.readonly.value,
                          contentPadding: const EdgeInsets.only(
                              left: 16, top: 2, bottom: 16),
                        ),
                        autofocus: false,
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: controller.direccionorig,
                        validator: controller.validateText,
                      ),
                      const LineContainer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 15),
                        child: FxText.bodyLarge("Dirección Destino *"),
                      ),
                      TextFormField(
                        style: FxTextStyle.bodyMedium(
                            color:
                                theme.colorScheme.onBackground.withAlpha(130),
                            fontWeight: 600,
                            letterSpacing: 0.2),
                        decoration: InputDecoration(
                          hintStyle: FxTextStyle.bodyLarge(
                              fontWeight: 500,
                              letterSpacing: 0,
                              color:
                                  theme.colorScheme.onBackground.withAlpha(70)),
                          hintText: "",
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          isDense: true,
                          enabled: controller.readonly.value,
                          contentPadding: const EdgeInsets.only(
                              left: 16, top: 2, bottom: 16),
                        ),
                        autofocus: false,
                        keyboardType: TextInputType.multiline,
                        // maxLength: 200,
                        maxLines: null,
                        controller: controller.direcciondest,
                        validator: controller.validateText,
                      ),
                      const LineContainer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 15),
                        child: FxText.bodyLarge("Observaciones"),
                      ),
                      TextFormField(
                        style: FxTextStyle.bodyMedium(
                            color:
                                theme.colorScheme.onBackground.withAlpha(130),
                            fontWeight: 600,
                            letterSpacing: 0.2),
                        decoration: InputDecoration(
                          hintStyle: FxTextStyle.bodyLarge(
                              fontWeight: 500,
                              letterSpacing: 0,
                              color:
                                  theme.colorScheme.onBackground.withAlpha(70)),
                          hintText: "",
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          isDense: true,
                          enabled: controller.readonly.value,
                          contentPadding: const EdgeInsets.only(
                              left: 16, top: 2, bottom: 16),
                        ),
                        autofocus: false,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: controller.observ,
                        // validator: controller.validateText,
                      ),
                      const LineContainer(),
                      const SizedBox(
                        height: 16,
                      ),
                      !controller.readonly.value
                          ? Container()
                          : CustomButton(
                              loading: controller.loadrequest.value,
                              text: widget.edit ? "Actualizar" : "Aceptar",
                              borderRadius: BorderRadius.circular(30),
                              onTap: () async {
                                widget.edit
                                    ? await controller.updateRequest()
                                    : await controller.createRequest();
                              },
                            ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  AppBar appbar() {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      toolbarHeight: 60,
      backgroundColor: theme.appBarTheme.backgroundColor,
      automaticallyImplyLeading: false,
      actionsIconTheme: IconThemeData(color: theme.primaryColor),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Builder(
              builder: (context) => IconButton(
                    icon: Icon(
                      FeatherIcons.arrowLeft,
                      color: theme.primaryColor,
                    ),
                    onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                        (Route<dynamic> route) => true),
                  )),
          Expanded(
              child: Visibility(
            visible: !controller.loadinggetrequest.value &&
                !controller.exeption.value,
            child: FxText.titleLarge(
              controller.status.value == "nueva"
                  ? 'Editar Solicitud' //
                  : controller.status.value == ""
                      ? 'Crear Solicitud' //
                      : 'Visualizar Solicitud', //
              textAlign: TextAlign.center,
              color: theme.primaryColor,
            ),
          )),
          const SizedBox(
            width: 5,
          ),
          Visibility(
            visible: !controller.loadinggetrequest.value &&
                !controller.exeption.value,
            child: IconButton(
                icon: Icon(
                  FeatherIcons.mapPin,
                  color: theme.primaryColor,
                ),
                onPressed: () {
                  _showBottomSheet(context);
                }),
          ),
          Visibility(
            visible:
                controller.loadinggetrequest.value && controller.exeption.value,
            child: SizedBox(
              height: 30,
              width: 60,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }

  Future<void> showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: const Text('Cancel booking'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want to cancel booking?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showBottomSheet(context) {
    showModalBottomSheet(
        enableDrag: false,
        isScrollControlled: true,
        showDragHandle: true,
        constraints: const BoxConstraints.expand(),
        context: context,
        builder: (BuildContext buildContext) {
          return Obx(() => Scaffold(
                // heightFactor: 0.8,
                appBar: AppBar(
                  centerTitle: true,
                  toolbarHeight: 60,
                  backgroundColor: theme.appBarTheme.backgroundColor,
                  // automaticallyImplyLeading: false,
                  actions: [
                    controller.readonly.value
                        ? Builder(
                            builder: (context) => IconButton(
                              icon: Icon(
                                FeatherIcons.trash,
                                color: theme.primaryColor,
                              ),
                              onPressed: () => controller.loadingrutes.value ||
                                      controller.geoloading.value ||
                                      controller.markmap.value
                                  ? null
                                  : controller.cleanMap(),
                            ),
                          )
                        : Container()
                  ],
                  leading: Builder(
                    builder: (context) => IconButton(
                        icon: Icon(
                          FeatherIcons.arrowLeft,
                          color: theme.primaryColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          controller.aceptPoints();
                        }),
                  ),
                  title: FxText.titleLarge(
                    controller.readonly.value
                        ? 'Seleccionar Ruta'
                        : 'Seguimiento de Ruta',
                    textAlign: TextAlign.center,
                    color: theme.primaryColor,
                  ),
                ),

                body: Padding(
                  padding: FxSpacing.fromLTRB(1, 1, 1, 1),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        // width: Get.width,
                        // height: Get.height * 0.92,
                        child: Stack(
                          children: [
                            MapboxMap(
                                annotationOrder: annotationorder,
                                onMapCreated: controller.onMapCreated,
                                onMapClick: controller.readonly.value
                                    ? controller.geoloading.value ||
                                            controller.loadingrutes.value ||
                                            controller.markmap.value
                                        ? null
                                        : controller.onMapClick
                                    : null,
                                onStyleLoadedCallback: () => {
                                      // controller.loadstylemap(),

                                      widget.edit
                                          ? controller.loadstylemapRequestEdit()
                                          : controller.points.isNotEmpty
                                              ? controller.loadstylemap()
                                              : null,
                                    },
                                compassEnabled: false,
                                myLocationEnabled: false,
                                accessToken: Environment.mapboxkey,
                                initialCameraPosition:
                                    controller.initialCameraPosition),
                            Obx(() => Visibility(
                                  visible: controller.markmap.value,
                                  child: Container(
                                    height: double.infinity,
                                    color:
                                        theme.colorScheme.primary.withAlpha(30),
                                  ),
                                )),
                            Visibility(
                              visible: controller.distance != "",
                              child: PositionedDirectional(
                                top: 20,
                                start: 20,
                                end: 20,
                                child: FadedScaleAnimation(
                                  child: FxContainer.bordered(
                                    padding: const EdgeInsets.only(
                                        right: 16, left: 16, bottom: 0, top: 0),
                                    borderRadius: BorderRadius.circular(12),
                                    color: theme.colorScheme.background,
                                    child: Row(
                                      children: [
                                        Column(
                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            RotatedBox(
                                                quarterTurns: 1,
                                                child: Text(' ------- ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .copyWith(
                                                            height: 1.1))),
                                          ],
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              CustomListTile(
                                                  title: "Distancia",
                                                  subtitle:
                                                      '${controller.distance.value.toString()} Km'),
                                            ],
                                          ),
                                        ),
                                        Obx(() => Expanded(
                                              child: Column(
                                                children: [
                                                  CustomListTile(
                                                      title:
                                                          "Costo de solicitud",
                                                      subtitle:
                                                          '${!controller.changefeeview.value && widget.edit ? controller.costo.value.toString() : num.parse(controller.distance.value) * controller.feeupdate.value} cup'),
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: true,
                              child: PositionedDirectional(
                                bottom: 40,
                                start: 20,
                                end: 20,
                                child: FadedScaleAnimation(
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: theme.colorScheme.background,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              // crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                CircleAvatar(
                                                  radius: 6,
                                                  backgroundColor:
                                                      theme.primaryColor,
                                                ),
                                                RotatedBox(
                                                    quarterTurns: 1,
                                                    child: Text(' ---------- ',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .copyWith(
                                                                height: 1.1))),
                                                const CircleAvatar(
                                                  radius: 6,
                                                  backgroundColor: Colors.red,
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: CustomListTile(
                                                            title: "Origen",
                                                            subtitle: controller
                                                                .geoorigin
                                                                .value),
                                                      ),
                                                      const SizedBox(
                                                        width: 12,
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    height: 0.5,
                                                    color: theme.hintColor,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 16),
                                                  ),
                                                  CustomListTile(
                                                      title: "Destino",
                                                      subtitle: controller
                                                          .geodestiny.value),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        CustomButton(
                                          loading:
                                              controller.loadingrutes.value ||
                                                  controller.geoloading.value ||
                                                  controller.markmap.value,
                                          text: "Aceptar",
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          onTap: () {
                                            Navigator.pop(context);
                                            controller.aceptPoints();
                                          },
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
