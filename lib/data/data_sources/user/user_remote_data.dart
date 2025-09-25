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

  Future<UserModel> fetchUserInfo() async {
    if (!await connectivityChecker.isConnected) {
      throw Exception('No internet connection');
    }
    final response = await apiClient.get('/users?includeRef=true');

    // The API returns a single user object
    if (response is Map<String, dynamic>) {
      return UserModel.fromJson(response);
    } else {
      throw Exception('Unexpected response format: expected Map<String, dynamic> but got ${response.runtimeType}');
    }
  }
}