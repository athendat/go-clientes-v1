import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';
import 'package:client.gogogo/data/models/request/mapbox_rutes_response.dart';
import 'package:client.gogogo/data/models/request/request.dart';
import 'package:client.gogogo/data/providers/map_box_provider.dart';
import 'package:client.gogogo/data/providers/request_provider.dart';
import 'package:client.gogogo/presentation/pages/home/screen/home_page.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class RequestController extends FxController {
  final bool edit;
  dynamic solicitud;
  TickerProvider ticker;
  late MapboxMapController mapController;
  var idsol;

  RequestController(this.ticker, this.edit, [this.solicitud]);

  var daterecogida = DateTime.now().obs;
  var daterecogidaUtc = DateTime.now().obs;
  List<Widget> newCategories = [];
  //List<Product>? products;
  bool showLoading = true, uiLoading = true;
  GlobalKey<FormState> formKey = GlobalKey();

  RangeValues selectedRange = const RangeValues(200, 800);

  MapBoxProvider mp = MapBoxProvider();
  RequestProvider rp = RequestProvider();
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
  Rx<num> feeupdate = 0.0.obs;
  var geoloading = false.obs;
  List<List<double>>? rutes = [];
  late List<CameraPosition> points = [];
  late MapboxMapController mapcontroller;
  final List<List<LatLng>> _defaultGeometry = [];
  final f = DateFormat('yyyy-MM-dd hh:mm aa');
  var costo = "".obs;
  late CameraPosition initialCameraPosition;
  //-------------variables del formulario---------------
  late TextEditingController title = TextEditingController(text: '');
  late TextEditingController fechar =
      TextEditingController(text: '2023-07-28T19:44:31.328Z');
  late TextEditingController cantpaqt = TextEditingController(text: '');
  late TextEditingController peso = TextEditingController(text: '');
  late TextEditingController volumen = TextEditingController(text: '');
  late TextEditingController valorcarga = TextEditingController(text: '');
  late TextEditingController direccionorig = TextEditingController(text: '');
  late TextEditingController direcciondest = TextEditingController(text: '');
  late TextEditingController observ = TextEditingController(text: '');
  var isImo = false.obs;
  var isRef = false.obs;
  Destiny origin = Destiny(type: "Point", coordinates: [0, 0]);
  Destiny destiny = Destiny(type: "Point", coordinates: [0, 0]);
  var status = "".obs;
  //-------------ned variables form-------------
  var styledloading = false.obs;
  var loadinggetrequest = false.obs;
  List<List<double>>? rutas = [];
  late LatLng orgg;
  late LatLng destt;
  List<List<double>>? rutass = [];
  //---------------------si es edit---------------
  Solicitud solicitudcarga = Solicitud(
      pickUpDate: DateTime.now().toIso8601String(),
      obs: "obs",
      weight: "0",
      volume: "0",
      packages: "0",
      value: "0",
      isImo: false,
      isRefrigerated: false,
      originAddress: "originAddress",
      destinyAddress: "destinyAddress",
      title: "title",
      origin: Destiny(type: "type", coordinates: [0, 0]),
      destiny: Destiny(type: "type", coordinates: [0, 0]),
      distance: 0);
  var readonly = true.obs;
  var changefeeview = false.obs;
  var markmap = false.obs;
  @override
  Future<void> initState() async {
    super.initState();
    initialCameraPosition = const CameraPosition(
      target: LatLng(22.001565, -79.352617),
      zoom: 4.5,
    );
    edit ? loadinggetrequest.value = true : null;
    await getsession();

    var box = await Hive.openBox('SessionFR');
    var a = box.get('fee');
    feeupdate.value = num.parse(a);

    edit ? cargaedit() : readonly.value = true;

    title = TextEditingController(text: '');
    //  await getrequests();
  }

  void onMapClick(point, coordinates) async {
    markmap.value = true;
    try {
      if (points.length == 2 || rutas!.isNotEmpty) {
        distance.value = "";
        geoorigin.value = "";
        geodestiny.value = "";
        update();
        rutas!.clear();
        rutes!.clear();
        points.clear();
        mapcontroller.removeSymbols(mapcontroller.symbols);
        mapcontroller.removeLayer("lines");
        mapcontroller.removeSource("fills");
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

        update();
      }
      markmap.value = false;
    } catch (e) {
      markmap.value = false;
    }
  }

  cargaedit() async {
    try {
      loadinggetrequest.value = true;

      var carga = await getrequestById(solicitud['id']);
      edit && carga['status'] == 'nueva'
          ? changefeeview.value = true
          : changefeeview.value = false;
      if (carga != "Error Server") {
        rutas = await getRutesMapbox(
          '${carga['origin']['coordinates'][1].toString()},${carga['origin']['coordinates'][0].toString()}',
          '${carga['destiny']['coordinates'][1].toString()},${carga['destiny']['coordinates'][0].toString()}',
        );
        var org = [
          carga['origin']['coordinates'][1].toString(),
          carga['origin']['coordinates'][0].toString()
        ];
        var dest = [
          carga['destiny']['coordinates'][1].toString(),
          carga['destiny']['coordinates'][0].toString()
        ];

        orgg = LatLng(double.parse(org[1]), double.parse(org[0]));
        destt = LatLng(double.parse(dest[1]), double.parse(dest[0]));
        //  await loadstylemapRequestEdit();
        distance.value = carga['distance'].toString();
        title.text = carga['title'].toString();
        observ.text = carga['obs'].toString();

        costo.value = carga['realPrice'].toString();
        daterecogida.value = DateTime.parse(carga['pickUpDate']).toLocal();
        cantpaqt.text = carga['packages'].toString() == "null"
            ? ""
            : carga['packages'].toString();
        peso.text = carga['weight'].toString() == "null"
            ? ""
            : carga['weight'].toString();
        volumen.text = carga['volume'].toString() == "null"
            ? ""
            : carga['volume'].toString();
        // valorcarga.text = carga['value'].toString();
        geoorigin.value = carga['originAddress'].toString() ?? "";
        geodestiny.value = carga['destinyAddress'].toString() ?? "";
        direccionorig.text = carga['originAddress'].toString() ?? "";
        direcciondest.text = carga['destinyAddress'].toString() ?? "";
        // isImo.value = carga['isImo'];
        // isRef.value = carga['isRefrigerated'];
        idsol = carga['id'];
        status.value = carga['status'] ?? "Nueva";
        status.value != "nueva"
            ? readonly.value = false
            : readonly.value = true;
      } else {
        exeption.value = true;
      }
      loadinggetrequest.value = false;
    } on Exception {
      loadinggetrequest.value = false;
    }
  }

  Future<List<List<double>>?> getRutesMapbox(
      String origin, String destino) async {
    try {
      loadingrutes.value = true;
      update();
      ResponseMapboxRutes rutess = await mp.getrutes(origin, destino);
      rutess.code != "Error" || rutess.code != "NoSegment"
          ? rutes = rutess.routes![0].geometry!.coordinates
          : null;
      distance.value =
          ((rutess.routes![0].distance! / 1000).round()).toString() ?? "";

      update();
      loadingrutes.value = false;
      return rutes;
    } catch (e) {
      loadingrutes.value = false;
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

//validators--------------------------------------
  String? validateText(String? text) {
    if (text == null || text.isEmpty) {
      return "Porfavor introduzca el texto";
    }
    return null;
  }

  String? validatenumb(String? text) {
    if (text == null || text.isEmpty) {
      return "Porfavor introduzca el texto";
    } else if (!FxStringUtils.isDigitIncluded(text)) {
      return "Porfavor introduzca un correo válido";
    }
    return null;
  }

  String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return "Porfavor introduzca el correo";
    } else if (!FxStringUtils.isEmail(text)) {
      return "Porfavor introduzca un correo válido";
    }
    return null;
  }

//end validators-------------------------------------------------------

  Future<void> getgeoposition(String longitud, String latitud) async {
    geoloading.value = true;
    try {
      var resp = await mp.getgeocoding(longitud, latitud);

      geoorigin.value != ""
          ? geodestiny.value = resp.features![0].placeNameEs ?? ""
          : geoorigin.value = resp.features![0].placeNameEs ?? "";

      geoloading.value = false;
    } catch (e) {
      geoloading.value = false;
    }
  }

  Future<void> loadstylemap() async {
    // styledloading.value = true;
    update();
    mapcontroller.addSymbol(SymbolOptions(
      zIndex: -15,
      geometry: points[0].target,
      iconSize: 1.2,
      iconImage: "assets/img/png/pin4.png",
    ));

    mapcontroller.addSymbol(SymbolOptions(
      zIndex: -15,
      geometry: points[1].target,
      iconSize: 1.2,
      iconImage: "assets/img/png/pind.png",
    ));

    var fills = {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "id": 0,
          "properties": <String, dynamic>{},
          "geometry": {"coordinates": rutes, "type": "LineString"},
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

    //  styledloading.value = false;
    update();
  }

  Future<void> loadstylemapRequestEdit() async {
    update();
    mapcontroller.addSymbol(SymbolOptions(
      zIndex: -15,
      geometry: orgg,
      iconSize: 1.2,
      iconImage: "assets/img/png/pin4.png",
    ));

    mapcontroller.addSymbol(SymbolOptions(
      zIndex: -15,
      geometry: destt,
      iconSize: 1.2,
      iconImage: "assets/img/png/pind.png",
    ));

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
    update();
    //  styledloading.value = false;
  }

  Future<void> createRequest() async {
    if (points.isEmpty) {
      AlertController.show(
        "Error al crear la solicitud",
        "Debe seleccionar el origen y destino en el mapa",
        TypeAlert.warning,
      );
      return;
    }
    if (formKey.currentState!.validate()) {
      loadrequest.value = true;

      destiny.coordinates = [
        points[1].target.latitude,
        points[1].target.longitude,
      ];
      origin.coordinates = [
        points[0].target.latitude,
        points[0].target.longitude,
      ];

      Solicitud solicitud = Solicitud(
          pickUpDate: daterecogidaUtc.value.toIso8601String(),
          obs: observ.text,
          weight: peso.text == "" ? null : peso.text,
          volume: volumen.text == "" ? null : volumen.text,
          packages: cantpaqt.text == "" ? null : cantpaqt.text,
          value: "",
          isImo: false,
          isRefrigerated: false,
          originAddress: direccionorig.text,
          destinyAddress: direcciondest.text,
          title: title.text,
          origin: origin,
          destiny: destiny,
          distance: double.parse(distance.value));

      var resp = await rp.createRequest(solicitud);
      resp == "false"
          ? AlertController.show(
              "Lo sentimos",
              "Ha ocurrido un error al crear la solicitud",
              TypeAlert.error,
            )
          : AlertController.show(
              "Enhorabuena",
              "Se ha creado la solicitud correctamente",
              TypeAlert.success,
            );
      loadrequest.value = false;
      update();
      resp == "true"
          ? Navigator.of(context, rootNavigator: true).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            )
          : null;
    }
  }

  Future<void> updateRequest() async {
    if (orgg.latitude == null ||
        orgg.latitude == 0 ||
        destt.latitude == null ||
        destt.latitude == 0) {
      AlertController.show(
        "Error al crear la solicitud",
        "Debe seleccionar el origen y destino en el mapa",
        TypeAlert.error,
      );
      return;
    }
    /* if (points.isEmpty) {
      AlertController.show(
        "Error al crear la solicitud",
        "Debe seleccionar el origen y destino en el mapa",
        TypeAlert.warning,
      );
      return;
    }*/
    if (formKey.currentState!.validate()) {
      loadrequest.value = true;

      destiny.coordinates = [
        orgg.latitude,
        orgg.longitude,
      ];
      origin.coordinates = [
        destt.latitude,
        destt.longitude,
      ];

      Solicitud solicitud = Solicitud(
          pickUpDate: daterecogidaUtc.value.toIso8601String(),
          obs: observ.text,
          weight: peso.text == "" ? null : peso.text,
          volume: volumen.text == "" ? null : volumen.text,
          packages: cantpaqt.text == "" ? null : cantpaqt.text,
          value: valorcarga.text,
          isImo: isImo.value,
          isRefrigerated: isRef.value,
          originAddress: direccionorig.text,
          destinyAddress: direcciondest.text,
          title: title.text,
          origin: origin,
          destiny: destiny,
          distance: double.parse(distance.value));

      var resp = await rp.updateRequest(solicitud, idsol);
      resp == "false"
          ? AlertController.show(
              "Error al actualizar la solicitud",
              "Ah ocurrido un problema al crear la solicitud",
              TypeAlert.error,
            )
          : AlertController.show(
              "Enhorabuenaa!",
              "Solicitud actualizada satisfactoriamente!",
              TypeAlert.success,
            );
      loadrequest.value = false;

      resp == "true"
          // ignore: use_build_context_synchronously
          ? Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            )
          : null;
    }
  }

  Future<dynamic> getrequestById(String id) async {
    try {
      var resp = await rp.getrequestsbyId(id);
      resp == "Error Server"
          ? {
              AlertController.show(
                "Error al tratar de obtener la solicitud",
                resp.toString(),
                TypeAlert.error,
              ),
              exeption.value = true
            }
          : exeption.value = false;
      return resp;
    } catch (e) {
      AlertController.show(
        "Error al tratar de obtener la solicitud",
        e.toString(),
        TypeAlert.error,
      );
      exeption.value = true;
    }
  }

  void goBack() {
    Navigator.pop(context);
  }

  Future<bool> onWillPop() async {
    return true;
  }

  void onMapCreated(MapboxMapController controller) {
    mapcontroller = controller;
    mapcontroller
        .animateCamera(CameraUpdate.newCameraPosition(initialCameraPosition));
  }

  @override
  void dispose() {
    distance.value = "";
    geoorigin.value = "";
    geodestiny.value = "";
    cantpaqt.text = "";
    peso.text = "";
    //mapcontroller.dispose();
    super.dispose();
  }

  void cleanMap() {
    distance.value = "";
    geoorigin.value = "";
    geodestiny.value = "";
    update();
    rutas!.clear();
    rutes!.clear();
    points.clear();
    mapcontroller.removeSymbols(mapcontroller.symbols);
    mapcontroller.removeLayer("lines");
    mapcontroller.removeSource("fills");
    update();
  }

  @override
  String getTag() {
    return "request_controller";
  }

  void aceptPoints() async {
    // distance.value = distance.value;
    //  geoorigin.value = geoorigin.value;
    //  geodestiny.value = geodestiny.value;
    // points = points;

    orgg = LatLng(points[0].target.latitude, points[0].target.longitude);
    destt = LatLng(points[1].target.latitude, points[1].target.longitude);
    //  mapcontroller = mapcontroller;

    rutas = rutass;
    //rc.mapcontroller.onStyleLoadedCallback;
    //rc.update();
    // rc.loadstylemap();

    //rc.update();
    //Navigator.of(context);
  }
}
