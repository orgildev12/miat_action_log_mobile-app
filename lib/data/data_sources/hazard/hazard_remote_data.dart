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

    if (result is List) {
      return result.map((json) => HazardModel.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Unexpected response format: expected List but got ${result.runtimeType}');
    }
  }

  Future<void> postHazard(PostHazardModel hazard, String? token, bool isUserLoggedIn) async {
    if (!await connectivityChecker.isConnected) {
      throw Exception('No internet connection');
    }

    if (isUserLoggedIn) {
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };
      await apiClient.post('/hazard/', hazard.toJson(true), headers: headers);
      return;
    }

    await apiClient.post('/hazard/noLogin', hazard.toJson(false));
  }

}