class ServerException  implements Exception {
  final String error;
  final String message;
  final int statusCode;

  ServerException({
    required this.error,
    required this.message,
    required this.statusCode,
  });

  @override
  String toString() => '$error ($statusCode): $message';
}