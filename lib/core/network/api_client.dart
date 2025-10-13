import 'dart:convert';
import 'package:action_log_app/core/error/server_exception.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;

  ApiClient({required this.baseUrl});

  Future<dynamic> get(
    String endpoint, {
      Map<String, String>? headers,
    }) async {
      print('ApiClient: Making GET request to: $baseUrl$endpoint');
      final response = await http.get(Uri.parse('$baseUrl$endpoint'), headers: headers);
      print('ApiClient: Response status: ${response.statusCode}');
      print('ApiClient: Raw response body: ${response.body}');
      return _handleResponse(response);
    }

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

    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: mergedHeaders,
      body: jsonEncode(body),
    );
    print('ApiClient: Response status: ${response.statusCode}');
    print('ApiClient: Raw response body: ${response.body}');
    return _handleResponse(response);
  }

    dynamic _handleResponse(http.Response response){
      final data = jsonDecode(response.body);

      if(response.request?.method == 'POST'){
        return response.statusCode;
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return data;
      } else {
        throw ServerException(
          error: data['name'],
          statusCode: response.statusCode,
        );
      }
    }
}