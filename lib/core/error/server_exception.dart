class ServerException  implements Exception {
  final String error;
  final int statusCode;

  ServerException({
    required this.error,
    required this.statusCode,
  });

  @override
  String toString() => '$error ($statusCode)';
}