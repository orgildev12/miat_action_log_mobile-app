import 'package:action_log_app/core/network/api_client.dart';
import 'package:action_log_app/core/network/connectivity_checker.dart';
import 'package:action_log_app/models/hazard_type_model.dart';

class HazardTypeRemoteDataSource {
  final ConnectivityChecker connectivityChecker;
  final ApiClient apiClient;

  HazardTypeRemoteDataSource({
    required this.connectivityChecker,
    required this.apiClient
  });

  Future<List<HazardTypeModel>> fetchHazardTypes() async {
    if(!await connectivityChecker.isConnected) {
      throw Exception('No internet connection');
    }
    final response = await apiClient.get('/hazardType');
    
    // The API returns a List<dynamic>, so we need to cast and map it
    if (response is List) {
      return response
          .map((item) => HazardTypeModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Unexpected response format: expected List but got ${response.runtimeType}');
    }
  }
}