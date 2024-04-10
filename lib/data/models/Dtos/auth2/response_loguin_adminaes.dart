import 'dart:convert';

RespLoguinAesadminDto respLoguinAesadminDtoFromJson(String str) =>
    RespLoguinAesadminDto.fromJson(json.decode(str));

String respLoguinAesadminDtoToJson(RespLoguinAesadminDto data) =>
    json.encode(data.toJson());

class RespLoguinAesadminDto {
  bool ok;
  int statusCode;
  String message;
  String token;
  User user;

  RespLoguinAesadminDto({
    required this.ok,
    required this.statusCode,
    required this.message,
    required this.token,
    required this.user,
  });

  factory RespLoguinAesadminDto.fromJson(Map<String, dynamic> json) =>
      RespLoguinAesadminDto(
        ok: json["ok"],
        statusCode: json["statusCode"],
        message: json["message"],
        token: json["token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "statusCode": statusCode,
        "message": message,
        "token": token,
        "user": user.toJson(),
      };
}

class User {
  String id;
  bool active;
  bool isBlock;
  bool isDeleted;
  String name;
  String lastname;
  String email;
  String phone;
  String username;
  String avatar;
  String bio;
  String pwd;
  String activationCode;
  List<String> roles;
  String idNumber;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String roleId;
  String merchantId;
  String fullname;
  Role role;

  User({
    required this.id,
    required this.active,
    required this.isBlock,
    required this.isDeleted,
    required this.name,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.username,
    required this.avatar,
    required this.bio,
    required this.pwd,
    required this.activationCode,
    required this.roles,
    required this.idNumber,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.roleId,
    required this.merchantId,
    required this.fullname,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        active: json["active"],
        isBlock: json["isBlock"],
        isDeleted: json["isDeleted"],
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        phone: json["phone"],
        username: json["username"],
        avatar: json["avatar"],
        bio: json["bio"],
        pwd: json["pwd"],
        activationCode: json["activationCode"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        idNumber: json["idNumber"],
        userId: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        roleId: json["roleId"],
        merchantId: json["merchantId"],
        fullname: json["fullname"],
        role: Role.fromJson(json["role"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "active": active,
        "isBlock": isBlock,
        "isDeleted": isDeleted,
        "name": name,
        "lastname": lastname,
        "email": email,
        "phone": phone,
        "username": username,
        "avatar": avatar,
        "bio": bio,
        "pwd": pwd,
        "activationCode": activationCode,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "idNumber": idNumber,
        "id": userId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "roleId": roleId,
        "merchantId": merchantId,
        "fullname": fullname,
        "role": role.toJson(),
      };
}

class Role {
  String id;
  String name;
  String description;
  bool roleStatic;
  bool isCoreRole;
  List<int> permissions;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Role({
    required this.id,
    required this.name,
    required this.description,
    required this.roleStatic,
    required this.isCoreRole,
    required this.permissions,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        roleStatic: json["static"],
        isCoreRole: json["isCoreRole"],
        permissions: List<int>.from(json["permissions"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "static": roleStatic,
        "isCoreRole": isCoreRole,
        "permissions": List<dynamic>.from(permissions.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
