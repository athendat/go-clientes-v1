// To parse this JSON data, do
//
//     final responseMapboxGeo = responseMapboxGeoFromJson(jsonString);

import 'dart:convert';

ResponseMapboxGeo responseMapboxGeoFromJson(String str) =>
    ResponseMapboxGeo.fromJson(json.decode(str));

String responseMapboxGeoToJson(ResponseMapboxGeo data) =>
    json.encode(data.toJson());

class ResponseMapboxGeo {
  String? type;
  List<double>? query;
  List<Feature>? features;
  String? attribution;

  ResponseMapboxGeo({
    this.type,
    this.query,
    this.features,
    this.attribution,
  });

  factory ResponseMapboxGeo.fromJson(Map<String, dynamic> json) =>
      ResponseMapboxGeo(
        type: json["type"],
        query: json["query"] == null
            ? []
            : List<double>.from(json["query"]!.map((x) => x?.toDouble())),
        features: json["features"] == null
            ? []
            : List<Feature>.from(
                json["features"]!.map((x) => Feature.fromJson(x))),
        attribution: json["attribution"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "query": query == null ? [] : List<dynamic>.from(query!.map((x) => x)),
        "features": features == null
            ? []
            : List<dynamic>.from(features!.map((x) => x.toJson())),
        "attribution": attribution,
      };
}

class Feature {
  String? id;
  String? type;
  List<String>? placeType;
  int? relevance;
  Properties? properties;
  String? textEs;
  String? placeNameEs;
  String? text;
  String? placeName;
  List<double>? center;
  Geometry? geometry;
  List<Context>? context;
  String? languageEs;
  String? language;
  List<double>? bbox;

  Feature({
    this.id,
    this.type,
    this.placeType,
    this.relevance,
    this.properties,
    this.textEs,
    this.placeNameEs,
    this.text,
    this.placeName,
    this.center,
    this.geometry,
    this.context,
    this.languageEs,
    this.language,
    this.bbox,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: json["place_type"] == null
            ? []
            : List<String>.from(json["place_type"]!.map((x) => x)),
        relevance: json["relevance"],
        properties: json["properties"] == null
            ? null
            : Properties.fromJson(json["properties"]),
        textEs: json["text_es"],
        placeNameEs: json["place_name_es"],
        text: json["text"],
        placeName: json["place_name"],
        center: json["center"] == null
            ? []
            : List<double>.from(json["center"]!.map((x) => x?.toDouble())),
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(json["geometry"]),
        context: json["context"] == null
            ? []
            : List<Context>.from(
                json["context"]!.map((x) => Context.fromJson(x))),
        languageEs: json["language_es"],
        language: json["language"],
        bbox: json["bbox"] == null
            ? []
            : List<double>.from(json["bbox"]!.map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "place_type": placeType == null
            ? []
            : List<dynamic>.from(placeType!.map((x) => x)),
        "relevance": relevance,
        "properties": properties?.toJson(),
        "text_es": textEs,
        "place_name_es": placeNameEs,
        "text": text,
        "place_name": placeName,
        "center":
            center == null ? [] : List<dynamic>.from(center!.map((x) => x)),
        "geometry": geometry?.toJson(),
        "context": context == null
            ? []
            : List<dynamic>.from(context!.map((x) => x.toJson())),
        "language_es": languageEs,
        "language": language,
        "bbox": bbox == null ? [] : List<dynamic>.from(bbox!.map((x) => x)),
      };
}

class Context {
  String? id;
  String? mapboxId;
  String? wikidata;
  String? textEs;
  String? languageEs;
  String? text;
  String? language;
  String? shortCode;

  Context({
    this.id,
    this.mapboxId,
    this.wikidata,
    this.textEs,
    this.languageEs,
    this.text,
    this.language,
    this.shortCode,
  });

  factory Context.fromJson(Map<String, dynamic> json) => Context(
        id: json["id"],
        mapboxId: json["mapbox_id"],
        wikidata: json["wikidata"],
        textEs: json["text_es"],
        languageEs: json["language_es"],
        text: json["text"],
        language: json["language"],
        shortCode: json["short_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mapbox_id": mapboxId,
        "wikidata": wikidata,
        "text_es": textEs,
        "language_es": languageEs,
        "text": text,
        "language": language,
        "short_code": shortCode,
      };
}

class Geometry {
  List<double>? coordinates;
  String? type;

  Geometry({
    this.coordinates,
    this.type,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates: json["coordinates"] == null
            ? []
            : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x)),
        "type": type,
      };
}

class Properties {
  String? foursquare;
  bool? landmark;
  String? address;
  String? category;
  String? mapboxId;
  String? wikidata;
  String? shortCode;

  Properties({
    this.foursquare,
    this.landmark,
    this.address,
    this.category,
    this.mapboxId,
    this.wikidata,
    this.shortCode,
  });

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        foursquare: json["foursquare"],
        landmark: json["landmark"],
        address: json["address"],
        category: json["category"],
        mapboxId: json["mapbox_id"],
        wikidata: json["wikidata"],
        shortCode: json["short_code"],
      );

  Map<String, dynamic> toJson() => {
        "foursquare": foursquare,
        "landmark": landmark,
        "address": address,
        "category": category,
        "mapbox_id": mapboxId,
        "wikidata": wikidata,
        "short_code": shortCode,
      };
}
