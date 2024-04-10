// To parse this JSON data, do
//
//     final errorResponse = errorResponseFromJson(jsonString);

import 'dart:convert';

Response errorResponseFromJson(String str) =>
    Response.fromJson(json.decode(str));

String errorResponseToJson(Response data) => json.encode(data.toJson());

class Response {
  Response({
    required this.ok,
    required this.statusCode,
    required this.message,
  });

  bool ok;
  int? statusCode;
  String message;
  dynamic resp;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        ok: json["ok"],
        statusCode: json["statusCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "statusCode": statusCode,
        "message": message,
      };
}

// To parse this JSON data, do
//
//     final responseErrorDto = responseErrorDtoFromJson(jsonString);

ResponseErrorDto responseErrorDtoFromJson(String str) =>
    ResponseErrorDto.fromJson(json.decode(str));

String responseErrorDtoToJson(ResponseErrorDto data) =>
    json.encode(data.toJson());

class ResponseErrorDto {
  ResponseErrorDto({
    required this.statusCode,
    required this.message,
    required this.error,
  });

  int statusCode;
  List<String> message;
  String error;

  factory ResponseErrorDto.fromJson(Map<String, dynamic> json) =>
      ResponseErrorDto(
        statusCode: json["statusCode"],
        message: List<String>.from(json["message"].map((x) => x)),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": List<dynamic>.from(message.map((x) => x)),
        "error": error,
      };
}
