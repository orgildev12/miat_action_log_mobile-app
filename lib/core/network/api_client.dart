import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:action_log_app/core/error/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class ApiClient {
  final String baseUrl;

  ApiClient({required this.baseUrl});

  /// GET request with 1-minute timeout
  Future<dynamic> get(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    print('ApiClient: Making GET request to: $baseUrl$endpoint');

    try {
      final response = await http
          .get(Uri.parse('$baseUrl$endpoint'), headers: headers)
          .timeout(const Duration(seconds: 30));

      print('ApiClient: Response status: ${response.statusCode}');
      print('ApiClient: Raw response body: ${response.body}');
      return _handleResponse(response);
    } on TimeoutException {
      throw ServerException(
        statusCode: 408,
        title: 'Request Timeout',
        message: 'The GET request to $endpoint timed out after 1 minute.',
      );
    }
  }

  /// POST request with 1-minute timeout
  Future<dynamic> post(
    String endpoint,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
  }) async {
    final defaultHeaders = {'Content-Type': 'application/json'};
    final mergedHeaders = {...defaultHeaders, ...?headers};

    print('ApiClient: Making POST request to: $baseUrl$endpoint');
    print('ApiClient: Request headers: $mergedHeaders');
    print('ApiClient: Request body: ${jsonEncode(body)}');

    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl$endpoint'),
            headers: mergedHeaders,
            body: jsonEncode(body),
          )
          .timeout(const Duration(minutes: 1));

      print('ApiClient: Response status: ${response.statusCode}');
      print('ApiClient: Raw response body: ${response.body}');
      return _handleResponse(response);
    } on TimeoutException {
      throw ServerException(
        statusCode: 408,
        title: 'Request Timeout',
        message: 'The POST request to $endpoint timed out after 1 minute.',
      );
    }
  }

  /// Multipart POST for uploading images with 1-minute timeout
  Future<dynamic> postMultipart(
    String endpoint, {
    required List<File> files,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final request = http.MultipartRequest('POST', uri);

    if (headers != null) {
      request.headers.addAll(headers);
    }

    for (final file in files) {
      final mimeType = lookupMimeType(file.path) ?? 'image/jpeg';
      final mimeParts = mimeType.split('/');

      request.files.add(
        await http.MultipartFile.fromPath(
          'images',
          file.path,
          contentType: MediaType(mimeParts[0], mimeParts[1]),
        ),
      );
    }

    print('ApiClient: Uploading ${files.length} image(s) to: $uri');

    try {
      final streamedResponse = await request.send().timeout(const Duration(minutes: 1));
      final response = await http.Response.fromStream(streamedResponse);

      print('ApiClient: Response status: ${response.statusCode}');
      print('ApiClient: Raw response body: ${response.body}');
      return _handleResponse(response);
    } on TimeoutException {
      throw ServerException(
        statusCode: 408,
        title: 'Request Timeout',
        message: 'The multipart POST request to $endpoint timed out after 1 minute.',
      );
    }
  }

  /// Handles decoding and error checking
  dynamic _handleResponse(http.Response response) {
    if (response.body.isEmpty) return null;

    final data = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    } else {
      throw ServerException(
        statusCode: response.statusCode,
        title: '',
        message: data is Map && data['message'] != null
            ? data['message']
            : 'Server error',
      );
    }
  }
}
