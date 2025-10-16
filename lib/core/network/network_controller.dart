import 'package:action_log_app/core/di/features/user_di.dart';
import 'package:action_log_app/l10n/app_localizations.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  // final AuthController _authController = AuthController();
  
  @override
  void onInit() {
    super.onInit();

    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      final result = results.isNotEmpty ? results.first : ConnectivityResult.none;
      _updateConnectionStatus(result);
    });
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    // Calculate top margin dynamically to appear below status bar + AppBar
    

    if (result == ConnectivityResult.none) {
      if (!Get.isSnackbarOpen) {
        Get.rawSnackbar(
          messageText: Text(
            AppLocalizations.of(Get.context!)!.noInternet,
            // 'Өө... Та одоо оффлайн байна',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: danger,
          icon: const KeyedSubtree(
            key: ValueKey('wifiIcon'),
            child: Icon(Icons.wifi_off, color: white),
          ),
          snackStyle: SnackStyle.FLOATING,
          borderRadius: 16,
          margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          duration: const Duration(days: 1),
          animationDuration: const Duration(milliseconds: 400),
          isDismissible: true,
          snackPosition: SnackPosition.TOP,
          overlayBlur: 0,
        );
      }
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
        UserDI.controller.userActivityDetected();
        Get.rawSnackbar(
          messageText: const Text(
            'Онлайн боллоо',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: success,
          // icon: const Icon(Icons.wifi, color: Colors.white),
          snackStyle: SnackStyle.FLOATING,
          borderRadius: 16,
          margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
          padding: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
          animationDuration: const Duration(milliseconds: 400),
          isDismissible: true,
          snackPosition: SnackPosition.TOP,
          overlayBlur: 0,
        );
      }
    }
  }
}
