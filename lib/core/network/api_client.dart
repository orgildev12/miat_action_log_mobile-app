import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:action_log_app/core/error/server_exception.dart';

class ApiClient {
  final String baseUrl;

  ApiClient({required this.baseUrl});

  Future<Map<String, dynamic>> get(
    String endpoint, {
      Map<String, String>? headers,
    }) async {
      final response = await http.get(Uri.parse('$baseUrl$endpoint'), headers: headers);
      return _handleResponse(response);
    }

  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
  }) async {
    final defaultHeaders = {'Content-Type': 'application/json'};
    final mergedHeaders = {...defaultHeaders, ...?headers};
    
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: mergedHeaders,
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
  }) async {
    final defaultHeaders = {'Content-Type': 'application/json'};
    final mergedHeaders = {...defaultHeaders, ...?headers};
    
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: mergedHeaders,
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

    Map<String, dynamic> _handleResponse(http.Response response){
      final data = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return data;
      } else {
        throw ServerException(
          error: data['error'] ?? 'Unknown Error',
          message: data['message'] ?? 'No message provided',
          statusCode: response.statusCode,
        );
      }
    }
}