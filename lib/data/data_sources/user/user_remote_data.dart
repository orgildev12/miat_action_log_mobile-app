import 'package:action_log_app/core/error/exceptions.dart';
import 'package:action_log_app/core/network/api_client.dart';
import 'package:action_log_app/core/network/connectivity_checker.dart';
import 'package:action_log_app/models/user_model.dart';

class UserRemoteDataSource {
  final ConnectivityChecker connectivityChecker;
  final ApiClient apiClient;

  UserRemoteDataSource({
    required this.connectivityChecker,
    required this.apiClient,
  });

  Future<Map<String, dynamic>> login(String username, String password) async {
    if (!await connectivityChecker.isConnected) {
      throw SocketException();
    }
    try{
      final response = await apiClient.post(
        '/user/auth',
        {
          'user_name': username,
          'password': password,
        },
      );
      return response;
    }catch(e){
      rethrow;
    }
  }
  
  Future<UserModel> fetchUserInfo(int userId) async {
    if (!await connectivityChecker.isConnected) {
      throw SocketException();
    }

    try{
      final response = await apiClient.get('/user/$userId');
      return UserModel.fromJson(response);
    }catch(e){
      if(e is ServerException){
        rethrow;
      }
      throw Exception('Unexpected error occurred: $e');
    }
  }
}