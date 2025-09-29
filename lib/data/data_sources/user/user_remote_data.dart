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
      throw Exception('No internet connection');
    }
    final response = await apiClient.post(
      '/user/auth',
      {
        'user_name': username,
        'password': password,
      },
    );

    if (response is Map<String, dynamic>) {
      return response;
    } else {
      throw Exception('Unexpected response format: expected Map<String, dynamic> but got ${response.runtimeType}');
    }
  }
  
  Future<UserModel> fetchUserInfo(int userId) async {
    if (!await connectivityChecker.isConnected) {
      throw Exception('No internet connection');
    }
    final response = await apiClient.get('/user/$userId');

    // The API returns a single user object
    if (response is Map<String, dynamic>) {
      return UserModel.fromJson(response);
    } else {
      throw Exception('Unexpected response format: expected Map<String, dynamic> but got ${response.runtimeType}');
    }
  }
}