import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  UserData({
    required this.ok,
    required this.message,
    required this.statusCode,
    required this.user,
  });

  bool ok;
  String message;
  int statusCode;
  Userd user;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        ok: json["ok"],
        message: json["message"],
        statusCode: json["statusCode"],
        user: Userd.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "message": message,
        "statusCode": statusCode,
        "user": user.toJson(),
      };
}

class Userd {
  Userd({
    required this.id,
    required this.active,
    required this.agreements,
    required this.name,
    required this.lastname,
    required this.email,
    required this.points,
    required this.activationCode,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    // required this.forgotPExpirationC,
    // required this.forgotPasswordCode,
  });

  String id;
  bool active;
  bool agreements;
  String name;
  String lastname;
  String email;
  int points;
  String activationCode;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  // DateTime? forgotPExpirationC;
  // String? forgotPasswordCode;

  factory Userd.fromJson(Map<String, dynamic> json) => Userd(
        id: json["_id"],
        active: json["active"],
        agreements: json["agreements"],
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        points: json["points"],
        activationCode: json["activationCode"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        //  forgotPExpirationC: DateTime.parse(json["forgotPExpirationC"]),
        //  forgotPasswordCode: json["forgotPasswordCode"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "active": active,
        "agreements": agreements,
        "name": name,
        "lastname": lastname,
        "email": email,
        "points": points,
        "activationCode": activationCode,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        //   "forgotPExpirationC": forgotPExpirationC?.toIso8601String(),
        //  "forgotPasswordCode": forgotPasswordCode,
      };
}
