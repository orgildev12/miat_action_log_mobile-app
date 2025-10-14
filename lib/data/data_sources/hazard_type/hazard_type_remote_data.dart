import 'package:action_log_app/core/error/server_exception.dart';
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
    if (!await connectivityChecker.isConnected) {
      throw Exception('No internet connection');
    }
    
    try{
      final data = await apiClient.get('/hazardType');
      if(data is! List){
        throw Exception('Invalid data format received');
      }
      return data
          .map((item) => HazardTypeModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }catch(e){
      if(e is ServerException){
        rethrow;
      }
      throw Exception('Unexpected error occurred: $e');
    }
  }
}