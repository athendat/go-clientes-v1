import 'dart:convert';

import 'package:flutter/services.dart';

List<Municipios> municipiosFromJson(String str) =>
    List<Municipios>.from(json.decode(str).map((x) => Municipios.fromJson(x)));

String municipiosToJson(List<Municipios> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Municipios {
  String state;
  String city;

  Municipios({
    required this.state,
    required this.city,
  });

  static Future<List<Municipios>> getDummyList() async {
    dynamic data = json.decode(await getData());
    return getListFromJson(data);
  }

  static List<Municipios> getListFromJson(List<dynamic> jsonArray) {
    List<Municipios> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(Municipios.fromJson(jsonArray[i]));
    }
    return list;
  }

  factory Municipios.fromJson(Map<String, dynamic> json) => Municipios(
        state: json["state"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "state": state,
        "city": city,
      };

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/json/municipios.json');
  }
}
