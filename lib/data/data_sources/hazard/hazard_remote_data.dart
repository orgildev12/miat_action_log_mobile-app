import 'package:action_log_app/core/network/api_client.dart';
import 'package:action_log_app/core/network/connectivity_checker.dart';
import 'package:action_log_app/models/hazard_model.dart';
import 'package:action_log_app/models/hazard_model_for_post.dart';

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
    final result = await apiClient.get('/hazard/byUserId/5366');
    
    // Backend returns a direct array, not wrapped in data property
    if (result is List) {
      return result.map((json) => HazardModel.fromJson(json as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Unexpected response format: expected List but got ${result.runtimeType}');
    }
  }

  Future<void> postHazard(PostHazardModel hazard, isUserLoggedIn) async {
    if(!await connectivityChecker.isConnected) {
      throw Exception('No internet connection');
    }
    if(isUserLoggedIn != false){
      await apiClient.post('/hazard/', hazard.toJson(true));
      return;
    }
    await apiClient.post('/hazard/noLogin', hazard.toJson(false));
  }

}