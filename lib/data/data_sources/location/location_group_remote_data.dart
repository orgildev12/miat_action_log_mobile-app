import 'package:action_log_app/core/network/api_client.dart';
import 'package:action_log_app/core/network/connectivity_checker.dart';
import 'package:action_log_app/models/location_group_model.dart';

class LocationGroupRemoteDataSource {
  final ConnectivityChecker connectivityChecker;
  final ApiClient apiClient;

  LocationGroupRemoteDataSource({
    required this.connectivityChecker,
    required this.apiClient,
  });

  Future<List<LocationGroupModel>> fetchLocationGroups() async {
    if(!await connectivityChecker.isConnected) {
      throw Exception('No internet connection');
    } 
    final response = await apiClient.get('/locationGroup');
    
    // The API returns a List<dynamic>, so we need to cast and map it
    if (response is List) {
      return response
          .map((item) => LocationGroupModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Unexpected response format: expected List but got ${response.runtimeType}');
    }
  }
}