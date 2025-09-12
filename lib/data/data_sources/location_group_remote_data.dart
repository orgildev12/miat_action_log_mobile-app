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

  Future<LocationGroupModel> fetchLocationGroup() async {
    if(!await connectivityChecker.isConnected) {
      throw Exception('No internet connection');
    } 
    final response = await apiClient.get('/location-groups');
    return LocationGroupModel.fromJson(response);
  }
}