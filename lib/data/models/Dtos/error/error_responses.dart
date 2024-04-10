import 'dart:convert';

ErrorResponses errorResponsesFromJson(String str) =>
    ErrorResponses.fromJson(json.decode(str));

String errorResponsesToJson(ErrorResponses data) => json.encode(data.toJson());

class ErrorResponses {
  Responses response;
  int status;
  Options options;
  String message;
  String name;

  ErrorResponses({
    required this.response,
    required this.status,
    required this.options,
    required this.message,
    required this.name,
  });

  factory ErrorResponses.fromJson(Map<String, dynamic> json) => ErrorResponses(
        response: Responses.fromJson(json["response"]),
        status: json["status"],
        options: Options.fromJson(json["options"]),
        message: json["message"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "response": response.toJson(),
        "status": status,
        "options": options.toJson(),
        "message": message,
        "name": name,
      };
}

class Options {
  Options();

  factory Options.fromJson(Map<String, dynamic> json) => Options();

  Map<String, dynamic> toJson() => {};
}

class Responses {
  String message;
  String error;
  int statusCode;

  Responses({
    required this.message,
    required this.error,
    required this.statusCode,
  });

  factory Responses.fromJson(Map<String, dynamic> json) => Responses(
        message: json["message"],
        error: json["error"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "error": error,
        "statusCode": statusCode,
      };
}
