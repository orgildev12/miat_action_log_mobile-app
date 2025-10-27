import 'package:action_log_app/application/controllers/auth_controller.dart';
import 'package:action_log_app/core/network/api_client.dart';
import 'package:action_log_app/core/network/connectivity_checker.dart';
import 'package:action_log_app/core/network/network_controller.dart';
import 'package:action_log_app/core/utils/idle_manager.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CoreDI {
  static late final ConnectivityChecker _connectivityChecker;
  static late final ApiClient _apiClient;
  static late final NetworkController _networkController;
  static late final IdleManager _idleManager;

  static void setup() {
    // Network
    _connectivityChecker = ConnectivityCheckerImpl();
    _apiClient = ApiClient(baseUrl: dotenv.env['API_BASE_URL']!);

    // NetworkController via GetX
    _networkController = Get.put(NetworkController());

    // IdleManager setup
    _idleManager = IdleManager(
      onTimeout: () async {
        final authController = Get.isRegistered<AuthController>()
            ? Get.find<AuthController>()
            : null;
        if (authController != null && authController.isLoggedIn.value) {
          await authController.autoLogout();
        }
      },
      idleDuration: const Duration(minutes: 10),
    );

  }

  // Getters
  static ConnectivityChecker get connectivityChecker => _connectivityChecker;
  static ApiClient get apiClient => _apiClient;
  static NetworkController get networkController => _networkController;
  static IdleManager get idleManager => _idleManager;
}
