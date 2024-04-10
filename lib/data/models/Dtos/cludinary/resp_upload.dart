class RespUploadCloud {
  RespUploadCloud({
    required this.ok,
    required this.statusCode,
    required this.response,
  });

  bool ok;
  int? statusCode;
  dynamic response;
}
