class ApiException {
  String? message;
  int? statusCode;

  ApiException(this.message, this.statusCode);
}
