import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';
import 'package:client.gogogo/data/models/request/mapbox_rutes_response.dart';
import 'package:client.gogogo/data/models/request/request.dart';
import 'package:client.gogogo/data/providers/map_box_provider.dart';
import 'package:client.gogogo/presentation/pages/request/screen/request_page.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'request_controller.dart';

class RequestSelectController extends FxController {
  TickerProvider ticker;
  final bool edit;
  RequestSelectController(this.ticker, this.edit);
  late RequestController rc;

  late TextEditingController textsearch;

  late Tween<Offset> offset;

  bool showLoading = true, uiLoading = true;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  MapBoxProvider mp = MapBoxProvider();
  var loadrequest = false.obs;

  List<dynamic> requests = [];
  QueryResult? queryResult;
  var lod = false.obs;
  var exeption = false.obs;
  var userid = "".obs;
  var loadingrutes = false.obs;

  var nameuser = "".obs;
  var distance = "".obs;
  var geoorigin = "".obs;
  var geodestiny = "".obs;

  List<List<double>>? rutes = [];
  late List<CameraPosition> points = [];
  late MapboxMapController mapcontroller;

  var removeLayer = true;
  final List<AnnotationType> annotationorder = [
    AnnotationType.line,
    AnnotationType.fill,
    AnnotationType.circle,
    AnnotationType.symbol,
  ];
  final mapMarkers = [
    Destiny(type: "Point", coordinates: [23.096512, -82.378166]),
    Destiny(type: "Point", coordinates: [23.096512, -82.378700]),
  ];
  final List<List<LatLng>> _defaultGeometry = [];
  List<List<double>>? rutass = [];

  @override
  Future<void> initState() async {
    super.initState();
    rc = FxControllerStore.putOrFind(RequestController(ticker, edit));
    await getsession();

    textsearch = TextEditingController(text: '');

    //  await getrequests();
  }

  Future<List<List<double>>?> getRutesMapbox(
      String origin, String destino) async {
    try {
      loadingrutes.value = true;
      update();
      ResponseMapboxRutes rutess = await mp.getrutes(origin, destino);
      rutess.code != "ERROR"
          ? rutes = rutess.routes![0].geometry!.coordinates
          : null;
      distance.value =
          ((rutess.routes![0].distance! / 1000).round()).toString() ?? "";
      loadingrutes.value = false;
      update();
      return rutes;
    } on Exception catch (e) {
    } finally {
      loadingrutes.value = false;
      update();
    }
    return null;
  }

  Future<void> getsession() async {
    var box = await Hive.openBox('SessionFR');
    userid.value = box.get('iduser');
  }

  void goToProductScreen(dynamic product) {
    Navigator.of(context, rootNavigator: false).push(
      PageRouteBuilder(
          transitionDuration: const Duration(seconds: 1),
          pageBuilder: (_, __, ___) => Container()),
    );
  }

  void goBack() {
    Navigator.pop(context);
  }

  Future<bool> onWillPop() async {
    return true;
  }

  @override
  String getTag() {
    return "request_select_controller";
  }

  void Update() {
    update();
  }

  Future<void> getgeoposition(String longitud, String latitud) async {
    try {
      loadingrutes.value = true;
      update();

      var resp = await mp.getgeocoding(longitud, latitud);

      resp.features == null
          ? AlertController.show(
              "Error al obtener geoposicion",
              "Problemas de conexion",
              TypeAlert.error,
            )
          : null;

      if (resp.features != null) {
        geoorigin.value != ""
            ? geodestiny.value = resp.features![0].placeNameEs ?? ""
            : geoorigin.value = resp.features![0].placeNameEs ?? "";
        geoorigin.value != "" ? loadingrutes.value = false : null;
      }
      update();
    } on Exception {
      AlertController.show(
        "Error al obtener geoposicion",
        "UProblemas de conexion",
        TypeAlert.error,
      );
    } finally {
      loadingrutes.value = false;
      update();
    }
  }

  void onMapClick(point, coordinates) async {
    if (points.length == 2) {
      distance.value = "";
      geoorigin.value = "";
      geodestiny.value = "";
      update();
      rutes!.clear();
      points.clear();
      mapcontroller.removeSymbols(mapcontroller.symbols);
      await mapcontroller.removeLayer("lines");
      await mapcontroller.removeSource("fills");
    }

    points.add(CameraPosition(
      target: coordinates,
    ));
    points.length == 1
        ? mapcontroller.addSymbol(SymbolOptions(
            zIndex: -15,
            geometry: coordinates,
            iconSize: 1.2,
            iconImage: "assets/img/png/pin4.png",
          ))
        : mapcontroller.addSymbol(SymbolOptions(
            zIndex: -15,
            geometry: coordinates,
            iconSize: 1.2,
            iconImage: "assets/img/png/pind.png",
          ));

    /*  mapcontroller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      bearing: 0.0,
      target: coordinates,
      zoom: 13,
    )));*/

    await getgeoposition(
        coordinates.longitude.toString(), coordinates.latitude.toString());

    if (points.length == 2) {
      var rutas = await getRutesMapbox(
        '${points[0].target.longitude.toString()},${points[0].target.latitude.toString()}',
        '${points[1].target.longitude.toString()},${points[1].target.latitude.toString()}',
      );

      rutass = rutas;

      if (rutas!.isNotEmpty) {
        var fills = {
          "type": "FeatureCollection",
          "features": [
            {
              "type": "Feature",
              "id": 0,
              "properties": <String, dynamic>{},
              "geometry": {"coordinates": rutas, "type": "LineString"},
            },
          ]
        };

        // Remove lineLayer and source if it exists

        await mapcontroller.removeLayer("lines");
        await mapcontroller.removeSource("fills");

        mapcontroller.addFill(
          FillOptions(
              geometry: _defaultGeometry,
              fillColor: "#FF0000",
              fillOutlineColor: "#FF0000"),
        );

        // Add new source and lineLayer
        await mapcontroller.addSource(
            "fills", GeojsonSourceProperties(data: fills));

        await mapcontroller.addLineLayer(
            "fills",
            "lines",
            const LineLayerProperties(
                lineColor: '#253F3E',
                lineCap: "round",
                lineJoin: "round",
                lineWidth: 5));
      }
    }
  }

  void aceptPoints() async {
    rc.distance.value = distance.value;
    rc.geoorigin.value = geoorigin.value;
    rc.geodestiny.value = geodestiny.value;
    rc.points = points;

    rc.mapcontroller = mapcontroller;

    rc.rutes = rutass;
    //rc.mapcontroller.onStyleLoadedCallback;
    //rc.update();
    // rc.loadstylemap();

    Navigator.of(context, rootNavigator: false).pop(
      PageRouteBuilder(
          transitionDuration: const Duration(seconds: 0),
          pageBuilder: (_, __, ___) =>
              RequestPage(edit: edit, solicitud: null)),
    );
    // Navigator.pushNamed(context, "/request");
    //rc.update();
    //Navigator.of(context);
  }

  Future<void> cleanMap() async {
    distance.value = "";
    geoorigin.value = "";
    geodestiny.value = "";
    update();
    rutes!.clear();
    points.clear();
    mapcontroller.removeSymbols(mapcontroller.symbols);
    await mapcontroller.removeLayer("lines");
    await mapcontroller.removeSource("fills");
  }
}
