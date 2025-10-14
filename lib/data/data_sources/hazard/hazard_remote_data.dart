import 'package:action_log_app/core/error/server_exception.dart';
import 'package:action_log_app/core/network/api_client.dart';
import 'package:action_log_app/core/network/connectivity_checker.dart';
import 'package:action_log_app/models/hazard_model.dart';
import 'package:action_log_app/models/post_hazard_model.dart';

class HazardRemoteDataSource {
  final ConnectivityChecker connectivityChecker;
  final ApiClient apiClient;

  HazardRemoteDataSource({
    required this.connectivityChecker,
    required this.apiClient
  });

  // Hazard operations
  Future<List<HazardModel>> fetchHazards(int userId, String token) async {
    if (!await connectivityChecker.isConnected) {
      throw Exception('No internet connection');
    }
    final headers = {
      'Authorization': 'Bearer $token',
    };
    print(headers);
    final result = await apiClient.get('/hazard/byUserId/$userId', headers: headers);

    try{
      if(result is! List){
        throw Exception('Invalid data format received');
      }
      return result.map((json) => HazardModel.fromJson(json as Map<String, dynamic>)).toList();
    } catch(e){
      if(e is ServerException){
        rethrow;
      }
      throw Exception('Unexpected error occurred: $e');
    }
  }

  Future<bool> postHazard(PostHazardModel hazard, String? token, bool isUserLoggedIn) async {
    if (!await connectivityChecker.isConnected) {
      throw Exception('No internet connection');
    }

    if (isUserLoggedIn) {
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };
      try{
        final result = await apiClient.post('/hazard/', hazard.toJson(true), headers: headers);
        return result;
      } catch(e){
        if(e is ServerException){
          rethrow;
        }
        throw Exception('Failed to post hazard');
      }
    }

    try{
      final result = await apiClient.post('/hazard/noLogin', hazard.toJson(false));
      return result;
    } catch(e){
      if(e is ServerException){
        rethrow;
      }
      throw Exception('Failed to post hazard');
    }
  }
}