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

  Future<LocationModel> fetchLocations() async {
    if(!await connectivityChecker.isConnected) {
      throw Exception('No internet connection');
    } 
    final response = await apiClient.get('/location-group');
    return LocationModel.fromJson(response);
  }
}