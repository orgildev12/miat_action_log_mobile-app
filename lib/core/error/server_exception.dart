class ServerException implements Exception {
  final int statusCode;
  final String name;
  final String message;

  ServerException({
    required this.statusCode,
    required this.name,
    required this.message,
  });

  @override
  String toString() => '($statusCode) $name: $message';
}