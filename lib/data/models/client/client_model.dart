// To parse this JSON data, do
//
//     final client = clientFromJson(jsonString);

import 'dart:convert';

Clients clientFromJson(String str) => Clients.fromJson(json.decode(str));

String clientToJson(Clients data) => json.encode(data.toJson());

class Clients {
  String? id;
  String? name;
  String? lastname1;
  String? lastname2;
  String? email;
  dynamic idNumber;
  dynamic phone;
  dynamic gender;
  dynamic avatar;
  dynamic address;
  dynamic country;
  dynamic city;
  dynamic state;
  dynamic town;
  dynamic zip;
  dynamic birthday;
  dynamic age;
  String? fullname;

  Clients({
    this.id,
    this.name,
    this.lastname1,
    this.lastname2,
    this.email,
    this.idNumber,
    this.phone,
    this.gender,
    this.avatar,
    this.address,
    this.country,
    this.city,
    this.state,
    this.town,
    this.zip,
    this.birthday,
    this.age,
    this.fullname,
  });

  factory Clients.fromJson(Map<String, dynamic> json) => Clients(
        id: json["id"],
        name: json["name"],
        lastname1: json["lastname1"],
        lastname2: json["lastname2"],
        email: json["email"],
        idNumber: json["idNumber"],
        phone: json["phone"],
        gender: json["gender"],
        avatar: json["avatar"],
        address: json["address"],
        country: json["country"],
        city: json["city"],
        state: json["state"],
        town: json["town"],
        zip: json["zip"],
        birthday: json["birthday"],
        age: json["age"],
        fullname: json["fullname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastname1": lastname1,
        "lastname2": lastname2,
        "email": email,
        "idNumber": idNumber,
        "phone": phone,
        "gender": gender,
        "avatar": avatar,
        "address": address,
        "country": country,
        "city": city,
        "state": state,
        "town": town,
        "zip": zip,
        "birthday": birthday,
        "age": age,
        "fullname": fullname,
      };
}
