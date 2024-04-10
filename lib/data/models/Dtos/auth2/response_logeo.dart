// To parse this JSON data, do
//
//     final responseLogeo = responseLogeoFromJson(jsonString);

import 'dart:convert';

ResponseLogeo responseLogeoFromJson(String str) =>
    ResponseLogeo.fromJson(json.decode(str));

String responseLogeoToJson(ResponseLogeo data) => json.encode(data.toJson());

class ResponseLogeo {
  bool? ok;
  int? statusCode;
  String? message;
  User? user;
  List<dynamic>? navigations;
  String? token;

  ResponseLogeo({
    this.ok,
    this.statusCode,
    this.message,
    this.user,
    this.navigations,
    this.token,
  });

  factory ResponseLogeo.fromJson(Map<String, dynamic> json) => ResponseLogeo(
        ok: json["ok"],
        statusCode: json["statusCode"],
        message: json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        navigations: json["navigations"] == null
            ? []
            : List<dynamic>.from(json["navigations"]!.map((x) => x)),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "statusCode": statusCode,
        "message": message,
        "user": user?.toJson(),
        "navigations": navigations == null
            ? []
            : List<dynamic>.from(navigations!.map((x) => x)),
        "token": token,
      };
}

class User {
  String? id;
  bool? active;
  String? name;
  String? lastName;
  String? email;
  String? username;
  bool? isDarkMode;
  String? userId;
  Role? role;
  List<dynamic>? merchants;

  User({
    this.id,
    this.active,
    this.name,
    this.lastName,
    this.email,
    this.username,
    this.isDarkMode,
    this.userId,
    this.role,
    this.merchants,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        active: json["active"],
        name: json["name"],
        lastName: json["lastName"],
        email: json["email"],
        username: json["username"],
        isDarkMode: json["isDarkMode"],
        userId: json["id"],
        role: json["role"] == null ? null : Role.fromJson(json["role"]),
        merchants: json["merchants"] == null
            ? []
            : List<dynamic>.from(json["merchants"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "active": active,
        "name": name,
        "lastName": lastName,
        "email": email,
        "username": username,
        "isDarkMode": isDarkMode,
        "id": userId,
        "role": role?.toJson(),
        "merchants": merchants == null
            ? []
            : List<dynamic>.from(merchants!.map((x) => x)),
      };
}

class Role {
  String? id;
  String? roleId;
  String? name;
  bool? isCoreRole;
  bool? active;
  List<dynamic>? permissions;

  Role({
    this.id,
    this.roleId,
    this.name,
    this.isCoreRole,
    this.active,
    this.permissions,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["_id"],
        roleId: json["id"],
        name: json["name"],
        isCoreRole: json["isCoreRole"],
        active: json["active"],
        permissions: json["permissions"] == null
            ? []
            : List<dynamic>.from(json["permissions"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "id": roleId,
        "name": name,
        "isCoreRole": isCoreRole,
        "active": active,
        "permissions": permissions == null
            ? []
            : List<dynamic>.from(permissions!.map((x) => x)),
      };
}
