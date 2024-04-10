import 'dart:convert';

ResponseLoguinDtoAes responseLoguinDtoAesFromJson(String str) =>
    ResponseLoguinDtoAes.fromJson(json.decode(str));

String responseLoguinDtoAesToJson(ResponseLoguinDtoAes data) =>
    json.encode(data.toJson());

class ResponseLoguinDtoAes {
  bool ok;
  int statusCode;
  String message;
  String token;
  Client client;
  // List<Cart>? cart;

  ResponseLoguinDtoAes({
    required this.ok,
    required this.statusCode,
    required this.message,
    required this.token,
    required this.client,
    // required this.cart,
  });

  factory ResponseLoguinDtoAes.fromJson(Map<String, dynamic> json) =>
      ResponseLoguinDtoAes(
        ok: json["ok"],
        statusCode: json["statusCode"],
        message: json["message"],
        token: json["token"],
        client: Client.fromJson(json["client"]),
        /*  cart: json['cart']['cartItems'].isEmpty ||
                json['cart']['cartItems'] == null
            ? List<Cart>.from(json["cart"].map((x) => Cart.fromJson(x)))
            : [],*/
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "statusCode": statusCode,
        "message": message,
        "token": token,
        "client": client.toJson(),
        //  "cart": List<dynamic>.from(cart.map((x) => x.toJson())),
      };
}

class Cart {
  String productId;
  int quantity;

  Cart({
    required this.productId,
    required this.quantity,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        productId: json["productId"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "quantity": quantity,
      };
}

class Client {
  String id;
  bool active;
  String name;
  String lastname1;
  String lastname2;
  String email;
  String pwd;
  String clientId;
  dynamic birthday;
  dynamic age;
  String fullname;

  Client({
    required this.id,
    required this.active,
    required this.name,
    required this.lastname1,
    required this.lastname2,
    required this.email,
    required this.pwd,
    required this.clientId,
    required this.birthday,
    required this.age,
    required this.fullname,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["_id"],
        active: json["active"],
        name: json["name"],
        lastname1: json["lastname1"],
        lastname2: json["lastname2"],
        email: json["email"],
        pwd: json["pwd"],
        clientId: json["id"],
        birthday: json["birthday"],
        age: json["age"],
        fullname: json["fullname"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "active": active,
        "name": name,
        "lastname1": lastname1,
        "lastname2": lastname2,
        "email": email,
        "pwd": pwd,
        "id": clientId,
        "birthday": birthday,
        "age": age,
        "fullname": fullname,
      };
}
