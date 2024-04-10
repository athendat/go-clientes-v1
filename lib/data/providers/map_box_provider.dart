import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:client.gogogo/core/helpers/environment.dart';
import 'package:client.gogogo/data/models/request/mapbox_geocode_response.dart';
import 'package:client.gogogo/data/models/request/mapbox_rutes_response.dart';
import 'package:http/http.dart' as http;

class MapBoxProvider {
  Future<ResponseMapboxRutes> getrutes(String origin, String destino) async {
    try {
      ResponseMapboxRutes responseApi;
      var url = Uri.parse(Environment.getrutepolyline);

      final queryParameters = {
        'alternatives': 'true',
        'geometries': 'geojson',
        'language': 'es',
        'overview': 'full',
        'steps': 'true',
        'access_token': Environment.mapboxkey,
      };
      final uri = Uri.https(
          'api.mapbox.com',
          '/directions/v5/mapbox/driving/${origin}' ';' + '${destino}',
          queryParameters);

      final http.Response res = await http.get(uri);
      final data = json.decode(res.body);
      if (data['status'] != null) {
        responseApi = ResponseMapboxRutes(
          code: 'Error',
        );
      } else {
        responseApi = ResponseMapboxRutes.fromJson(data);
      }

      //  Response responseApi =
      // Response(ok: false, statusCode: 200, message: 'ok');

      return responseApi;
    } catch (e) {
      if (kDebugMode) {
        // print('Error: $e');
      }

      return ResponseMapboxRutes(
        code: 'Error',
      );
    }
  }

  //https://api.mapbox.com/geocoding/v5/mapbox.places/-82.36870048877277,23.12143422726068.json?language=es&access_token=
  Future<ResponseMapboxGeo> getgeocoding(String origin, String destino) async {
    try {
      ResponseMapboxGeo responseApi;

      final queryParameters = {
        'language': 'es',
        'access_token': Environment.mapboxkey,
      };
      final uri = Uri.https(
          'api.mapbox.com',
          '/geocoding/v5/mapbox.places/$origin' ',' '$destino.json',
          queryParameters);

      final http.Response res = await http.get(uri);
      final data = json.decode(res.body);
      if (data['status'] != null) {
        responseApi = ResponseMapboxGeo(attribution: "ERROR");
      } else {
        responseApi = ResponseMapboxGeo.fromJson(data);
      }

      return responseApi;
    } catch (e) {
      if (kDebugMode) {
        // print('Error: $e');
      }

      return ResponseMapboxGeo(attribution: "ERROR");
    }
  }
}
