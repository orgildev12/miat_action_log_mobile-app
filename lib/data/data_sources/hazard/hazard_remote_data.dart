import 'package:action_log_app/core/network/api_client.dart';
import 'package:action_log_app/core/network/connectivity_checker.dart';
import 'package:action_log_app/models/hazard_model.dart';
import 'package:action_log_app/models/response_model.dart';

class HazardRemoteDataSource {
  final ConnectivityChecker connectivityChecker;
  final ApiClient apiClient;

  HazardRemoteDataSource({
    required this.connectivityChecker,
    required this.apiClient
  });

  // Hazard operations
  Future<HazardModel> fetchHazard() async {
    if(!await connectivityChecker.isConnected) {
      throw Exception('No internet connection');
    }
    final result = await apiClient.get('/hazard');
    return HazardModel.fromJson(result);
  }

  Future<List<HazardModel>> fetchHazards() async {
    if(!await connectivityChecker.isConnected) {
      throw Exception('No internet connection');
    }
    final result = await apiClient.get('/hazard');
    
    // Backend returns a direct array, not wrapped in data property
    if (result is List) {
      return result.map((json) => HazardModel.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Unexpected response format: expected List but got ${result.runtimeType}');
    }
  }

  Future<void> postHazard(HazardModel hazard) async {
    if(!await connectivityChecker.isConnected) {
      throw Exception('No internet connection');
    }
    await apiClient.post('/hazard', hazard.toJson());
  }

  // Response operations (part of hazard feature)
  Future<ResponseModel?> fetchHazardResponse(int hazardId) async {
    if(!await connectivityChecker.isConnected) {
      throw Exception('No internet connection');
    }
    try {
      final result = await apiClient.get('/response/$hazardId');
      return ResponseModel.fromJson(result);
    } catch (e) {
      // Return null if response doesn't exist yet
      if (e.toString().contains('404')) {
        return null;
      }
      rethrow;
    }
  }

  Future<void> postHazardResponse(ResponseModel response) async {
    if(!await connectivityChecker.isConnected) {
      throw Exception('No internet connection');
    }
    await apiClient.post('/hazard/${response.hazardId}/response', response.toJson());
  }
}