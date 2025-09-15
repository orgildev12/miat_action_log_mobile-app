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

  Future<HazardTypeModel> fetchHazardType() async {
    if(!await connectivityChecker.isConnected) {
      throw Exception('No internet connection');
    }
    final result = await apiClient.get('/hazardType');
    return HazardTypeModel.fromJson(result);
  }
}