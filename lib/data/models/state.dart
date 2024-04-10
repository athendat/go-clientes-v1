import 'dart:convert';
import 'package:flutter/services.dart';

class Provincia {
  Provincia();
  static Future<List<String>> getDummyList() async {
    dynamic data = json.decode(await getData());
    return getListFromJson(data);
  }

  static List<String> getListFromJson(List<dynamic> jsonArray) {
    List<String> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(jsonArray[i]);
    }
    return list;
  }

  static List<String> provinciasFromJson(String str) =>
      List<String>.from(json.decode(str).map((x) => x));

  static String provinciasToJson(List<String> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x)));

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/json/states.json');
  }
}
