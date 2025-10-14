import 'package:action_log_app/core/error/server_exception.dart';
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

    try{
      final response = await apiClient.get('/locations?includeRef=true'); 
      if(response is! List) {
        // Энэ шалгалтыг хийх ямар ч шаардлагагүй боловч аваад хаячихаар алдаа заагаад байгаа.
        throw Exception('Unexpected response format: expected List but got ${response.runtimeType}');
      }
      return response
        .map((item) => LocationModel.fromJson(item as Map<String, dynamic>))
        .toList();
    }catch(e){
      if(e is ServerException){
        rethrow;
      }
      throw Exception('Failed to load locations: $e');
    }
  }
}