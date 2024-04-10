import 'dart:convert';

Rankigs rankigsFromJson(String str) => Rankigs.fromJson(json.decode(str));

String rankigsToJson(Rankigs data) => json.encode(data.toJson());

class Rankigs {
  Rankigs({
    required this.ok,
    required this.statusCode,
    required this.message,
    required this.ranking,
  });

  bool ok;
  int statusCode;
  String message;
  List<Ranking> ranking;

  factory Rankigs.fromJson(Map<String, dynamic> json) => Rankigs(
        ok: json["ok"],
        statusCode: json["statusCode"],
        message: json["message"],
        ranking:
            List<Ranking>.from(json["ranking"].map((x) => Ranking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "statusCode": statusCode,
        "message": message,
        "ranking": List<dynamic>.from(ranking.map((x) => x.toJson())),
      };
}

class Ranking {
  Ranking({
    required this.id,
    required this.name,
    required this.lastname,
    required this.points,
  });

  String id;
  String name;
  String lastname;
  int points;

  factory Ranking.fromJson(Map<String, dynamic> json) => Ranking(
        id: json["id"],
        name: json["name"],
        lastname: json["lastname"],
        points: json["points"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastname": lastname,
        "points": points,
      };
}
