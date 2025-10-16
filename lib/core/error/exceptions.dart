abstract class AppException implements Exception {
  String get title;
  String get message;
}

// class NetworkException extends AppException {
//   @override
//   final String title;
//   @override
//   final String message;

//   NetworkException([
//     this.title = '',
//     this.message = "Check your internet connection"
//   ]);
// }

class SocketException implements Exception {
  SocketException();
  // message-iig ni UI deer ugnu
}


class ServerException extends AppException {
  final int statusCode;
  @override
  String title;
  @override
  String message;

  ServerException({
    required this.statusCode,
    required this.title,
    required this.message,
  });
}
