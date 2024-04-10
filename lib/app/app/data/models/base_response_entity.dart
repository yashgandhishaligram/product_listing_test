class GenericResponseEntity {
  int? statusCode;
  bool success;
  String? message;
  dynamic data;

  GenericResponseEntity(
      {this.statusCode, required this.success, this.message, this.data});
}
