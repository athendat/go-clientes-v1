import 'dart:convert';

RankigsGlobals rankigsGlobalsFromJson(String str) =>
    RankigsGlobals.fromJson(json.decode(str));

String rankigsGlobalsToJson(RankigsGlobals data) => json.encode(data.toJson());

class RankigsGlobals {
  RankigsGlobals({
    required this.ok,
    required this.message,
    required this.statusCode,
    required this.ranking,
  });

  bool ok;
  String message;
  int statusCode;
  List<Ranking> ranking;

  factory RankigsGlobals.fromJson(Map<String, dynamic> json) => RankigsGlobals(
        ok: json["ok"],
        message: json["message"],
        statusCode: json["statusCode"],
        ranking:
            List<Ranking>.from(json["ranking"].map((x) => Ranking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "message": message,
        "statusCode": statusCode,
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
        id: json["_id"],
        name: json["name"],
        lastname: json["lastname"],
        points: json["points"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "lastname": lastname,
        "points": points,
      };
}
