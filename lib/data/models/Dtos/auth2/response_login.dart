// To parse this JSON data, do
//
//     final responseLogin = responseLoginFromJson(jsonString);

import 'dart:convert';

ResponseLogin responseLoginFromJson(String str) =>
    ResponseLogin.fromJson(json.decode(str));

String responseLoginToJson(ResponseLogin data) => json.encode(data.toJson());

class ResponseLogin {
  bool ok;
  int statusCode;
  String message;
  User user;
  List<dynamic> navigations;
  String token;

  ResponseLogin({
    required this.ok,
    required this.statusCode,
    required this.message,
    required this.user,
    required this.navigations,
    required this.token,
  });

  factory ResponseLogin.fromJson(Map<String, dynamic> json) => ResponseLogin(
        ok: json["ok"],
        statusCode: json["statusCode"],
        message: json["message"],
        user: User.fromJson(json["user"]),
        navigations: List<dynamic>.from(json["navigations"].map((x) => x)),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "statusCode": statusCode,
        "message": message,
        "user": user.toJson(),
        "navigations": List<dynamic>.from(navigations.map((x) => x)),
        "token": token,
      };
}

class User {
  String id;
  bool active;
  String name;
  String lastName;
  String email;
  String username;
  bool isDarkMode;
  String userId;
  Role role;
  List<dynamic> merchants;

  User({
    required this.id,
    required this.active,
    required this.name,
    required this.lastName,
    required this.email,
    required this.username,
    required this.isDarkMode,
    required this.userId,
    required this.role,
    required this.merchants,
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
        role: Role.fromJson(json["role"]),
        merchants: List<dynamic>.from(json["merchants"].map((x) => x)),
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
        "role": role.toJson(),
        "merchants": List<dynamic>.from(merchants.map((x) => x)),
      };
}

class Role {
  String id;
  String roleId;
  String name;
  bool isCoreRole;
  bool active;
  List<dynamic> permissions;

  Role({
    required this.id,
    required this.roleId,
    required this.name,
    required this.isCoreRole,
    required this.active,
    required this.permissions,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["_id"],
        roleId: json["id"],
        name: json["name"],
        isCoreRole: json["isCoreRole"],
        active: json["active"],
        permissions: List<dynamic>.from(json["permissions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "id": roleId,
        "name": name,
        "isCoreRole": isCoreRole,
        "active": active,
        "permissions": List<dynamic>.from(permissions.map((x) => x)),
      };
}
