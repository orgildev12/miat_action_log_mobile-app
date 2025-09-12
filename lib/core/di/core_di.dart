import 'package:action_log_app/core/network/api_client.dart';
import 'package:action_log_app/core/network/connectivity_checker.dart';

// Core services shared across all features
class CoreDI {
  static late final ConnectivityChecker _connectivityChecker;
  static late final ApiClient _apiClient;

  static void setup() {
    _connectivityChecker = ConnectivityCheckerImpl();
    _apiClient = ApiClient(baseUrl: 'http://localhost:3000');
  }

  // Getters for core services
  static ConnectivityChecker get connectivityChecker => _connectivityChecker;
  static ApiClient get apiClient => _apiClient;
}