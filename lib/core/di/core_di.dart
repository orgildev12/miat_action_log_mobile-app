import 'package:action_log_app/application/controllers/auth_controller.dart';
import 'package:action_log_app/core/network/api_client.dart';
import 'package:action_log_app/core/network/connectivity_checker.dart';
import 'package:action_log_app/core/network/network_controller.dart';
import 'package:action_log_app/core/utils/idle_manager.dart';
import 'package:get/get.dart';

class CoreDI {
  static late final ConnectivityChecker _connectivityChecker;
  static late final ApiClient _apiClient;
  static late final NetworkController _networkController;
  static late final IdleManager _idleManager;

  static void setup() {
    // Network
    _connectivityChecker = ConnectivityCheckerImpl();
    _apiClient = ApiClient(baseUrl: 'http://10.0.2.2:3000/api');

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
      idleDuration: const Duration(minutes: 1),
    );

  }

  // Getters
  static ConnectivityChecker get connectivityChecker => _connectivityChecker;
  static ApiClient get apiClient => _apiClient;
  static NetworkController get networkController => _networkController;
  static IdleManager get idleManager => _idleManager;
}
