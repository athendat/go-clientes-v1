import 'dart:convert';

Solicitud SolicitudFromJson(String str) => Solicitud.fromJson(json.decode(str));

String SolicitudToJson(Solicitud data) => json.encode(data.toJson());

class Solicitud {
  String pickUpDate;
  String obs;
  String? weight;
  String? volume;
  String? packages;
  String? value;
  bool isImo;
  bool isRefrigerated;
  String originAddress;
  String destinyAddress;
  String title;
  Destiny origin;
  Destiny destiny;
  double distance;
  //List<List<double>>? rute;

  Solicitud(
      {required this.pickUpDate,
      required this.obs,
      required this.weight,
      required this.volume,
      required this.packages,
      required this.value,
      required this.isImo,
      required this.isRefrigerated,
      required this.originAddress,
      required this.destinyAddress,
      required this.title,
      required this.origin,
      required this.destiny,
      required this.distance});

  factory Solicitud.fromJson(Map<String, dynamic> json) => Solicitud(
      pickUpDate: json["pickUpDate"],
      obs: json["obs"],
      weight: json["weight"],
      volume: json["volume"],
      packages: json["packages"],
      value: json["value"],
      isImo: json["isImo"],
      isRefrigerated: json["isRefrigerated"],
      originAddress: json["originAddress"],
      destinyAddress: json["destinyAddress"],
      title: json["title"],
      origin: Destiny.fromJson(json["origin"]),
      destiny: Destiny.fromJson(json["destiny"]),
      distance: json["distance"]?.toDouble());
  //  rute: json["rute"] ?? []);

  Map<String, dynamic> toJson() => {
        "pickUpDate": pickUpDate,
        "obs": obs,
        "weight": weight,
        "volume": volume,
        "packages": packages,
        "value": value,
        "isImo": isImo,
        "isRefrigerated": isRefrigerated,
        "originAddress": originAddress,
        "destinyAddress": destinyAddress,
        "title": title,
        "origin": origin.toJson(),
        "destiny": destiny.toJson(),
        "distance": distance
        //    "rute": rute
      };
}

class Destiny {
  String type;
  List<double> coordinates;

  Destiny({
    required this.type,
    required this.coordinates,
  });

  factory Destiny.fromJson(Map<String, dynamic> json) => Destiny(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}
