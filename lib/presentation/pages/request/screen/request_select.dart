import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:client.gogogo/core/helpers/environment.dart';
import 'package:client.gogogo/data/models/request/request.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_list_tile.dart';
import '../../../themes/theme/app_theme.dart';
import '../controller/request_select_controller.dart';

class RequestSelectPage extends StatefulWidget {
  final bool edit;
  const RequestSelectPage({Key? key, required this.edit}) : super(key: key);

  @override
  _RequestSelectPageState createState() => _RequestSelectPageState();
}

class _RequestSelectPageState extends State<RequestSelectPage>
    with TickerProviderStateMixin {
  late ThemeData theme;
  late RequestSelectController controller;

  late MapboxMapController mapcontroller;
  final mapMarkers = [
    Destiny(type: "Point", coordinates: [23.096512, -82.378166]),
    Destiny(type: "Point", coordinates: [23.096512, -82.378700]),
  ];
  final List<List<LatLng>> _defaultGeometry = [];

  late List<CameraPosition> points = [];

  var removeLayer = true;
  final List<AnnotationType> annotationorder = [
    AnnotationType.line,
    AnnotationType.fill,
    AnnotationType.circle,
    AnnotationType.symbol,
  ];
  @override
  void initState() {
    theme = AppTheme.shoppingLightTheme;

    controller =
        FxControllerStore.put(RequestSelectController(this, widget.edit));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = const CameraPosition(
      target: LatLng(23.09372975945294, -82.38548083738564),
      zoom: 10,
    );
    return FxBuilder<RequestSelectController>(
        controller: controller,
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              centerTitle: true,
              toolbarHeight: 60,
              backgroundColor: theme.appBarTheme.backgroundColor,
              // automaticallyImplyLeading: false,
              actions: [
                Builder(
                  builder: (context) => IconButton(
                    icon: Icon(
                      FeatherIcons.trash,
                      color: theme.primaryColor,
                    ),
                    onPressed: () async => await controller.cleanMap(),
                  ),
                )
              ],
              leading: Builder(
                builder: (context) => IconButton(
                    icon: Icon(
                      FeatherIcons.arrowLeft,
                      color: theme.primaryColor,
                    ),
                    onPressed: () => Navigator.pop(context)),
              ),
              title: FxText.titleLarge(
                'Seleccionar Ruta',
                textAlign: TextAlign.center,
                color: theme.primaryColor,
              ),
            ),
            body: Stack(
              children: [
                FadedScaleAnimation(
                  child: MapboxMap(
                      dragEnabled: true,
                      annotationOrder: annotationorder,
                      onMapCreated: (MapboxMapController mapcontroller) async {
                        controller.mapcontroller = mapcontroller;
                        this.mapcontroller = controller.mapcontroller;
                        controller.mapcontroller.animateCamera(
                            CameraUpdate.newCameraPosition(
                                initialCameraPosition));
                      },
                      onMapClick: controller.onMapClick,
                      onStyleLoadedCallback: () => {
                            // controller.
                          },
                      compassEnabled: true,
                      myLocationEnabled: true,
                      accessToken: Environment.mapboxkey,
                      initialCameraPosition: initialCameraPosition),
                ),
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
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: theme.colorScheme.background,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
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
                                                subtitle:
                                                    controller.geoorigin.value),
                                          ),
                                          const SizedBox(
                                            width: 12,
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
                                          subtitle:
                                              controller.geodestiny.value),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomButton(
                              loading: controller.loadingrutes.value,
                              text: "Aceptar",
                              borderRadius: BorderRadius.circular(30),
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
          );
        });
  }
}
