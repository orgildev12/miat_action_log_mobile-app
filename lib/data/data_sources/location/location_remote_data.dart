import 'package:action_log_app/core/network/api_client.dart';
import 'package:action_log_app/core/network/connectivity_checker.dart';
import 'package:action_log_app/models/location_model.dart';

class LocationRemoteDataSource {
  final ConnectivityChecker connectivityChecker;
  final ApiClient apiClient;

  LocationRemoteDataSource({
    required this.connectivityChecker,
    required this.apiClient,
  });

  Future<List<LocationModel>> fetchLocations() async {
    if(!await connectivityChecker.isConnected) {
      throw Exception('No internet connection');
    } 
    final response = await apiClient.get('/locations');
    
    // The API returns a List<dynamic>, so we need to cast and map it
    if (response is List) {
      return response
          .map((item) => LocationModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Unexpected response format: expected List but got ${response.runtimeType}');
    }
  }
}