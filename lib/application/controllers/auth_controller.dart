import 'dart:async';

import 'package:action_log_app/application/use_cases/user_use_cases/recover_token_use_case.dart';
import 'package:action_log_app/core/di/features/hazard_di.dart';
import 'package:action_log_app/l10n/app_localizations.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:action_log_app/application/use_cases/user_use_cases/login_user_case.dart';
import 'package:action_log_app/application/use_cases/user_use_cases/logout_user_use_case.dart';
import 'package:action_log_app/application/use_cases/user_use_cases/end_connection_use_case.dart';
import 'package:action_log_app/core/utils/idle_manager.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class AuthController {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final RecoverTokenUseCase _recoverTokenUseCase;
  final EndConnectionUseCase _endConnectionUseCase;
  final IdleManager _idleManager;

  // State notifier / listener-ээр UI-г мэдэгдэх боломжтой
  final ValueNotifier<bool> isLoggedIn = ValueNotifier(false);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<String?> errorMessage = ValueNotifier(null);

  AuthController({
    required LoginUseCase loginUseCase,
    required LogoutUseCase logoutUseCase,
    required RecoverTokenUseCase recoverTokenUseCase,
    required EndConnectionUseCase endConnectionUseCase,
    required IdleManager idleManager,
  })  : _loginUseCase = loginUseCase,
        _logoutUseCase = logoutUseCase,
        _recoverTokenUseCase = recoverTokenUseCase,
        _endConnectionUseCase = endConnectionUseCase,
        _idleManager = idleManager {
    // Idle timeout callback
    _idleManager.onTimeout = () async {
      final tokenExists = await _endConnectionUseCase.hasToken();
      if (tokenExists) {
        await autoLogout();
      }
    };
  }

  /// Login
  Future<void> login(String username, String password) async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      await _loginUseCase.call(username, password);
      isLoggedIn.value = true;
      _idleManager.enable(); // Хэрэглэгч нэвтэрсэн тул idle хянах
      print('logged in');
    } catch (e) {
      errorMessage.value = e.toString();
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> recoverToken(bool withMessage) async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      await _recoverTokenUseCase.call();
      final tokenExists = await _endConnectionUseCase.hasToken();
      if (tokenExists) {
        isLoggedIn.value = true;
        _idleManager.enable();

        if(withMessage){
          showRecoveredSnackBar();
        }
      } else {
        isLoggedIn.value = false;
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void showRecoveredSnackBar() {
    Get.showSnackbar(
      GetSnackBar(
        messageText: Text(
          AppLocalizations.of(Get.context!)!.connectionRecovered,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
        icon: const KeyedSubtree(
          key: ValueKey('wifiIcon'),
          child: Icon(IconsaxPlusLinear.wifi, color: success),
        ),
        snackStyle: SnackStyle.FLOATING,
        borderRadius: 16,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        duration: const Duration(seconds: 2),
        animationDuration: const Duration(milliseconds: 400), // <- controls speed
        isDismissible: true,
        snackPosition: SnackPosition.TOP,
        overlayBlur: 0,
        boxShadows: [
          BoxShadow(
            color: const Color.fromARGB(96, 35, 40, 59).withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );
  }

// color: const Color.fromARGB(96, 35, 40, 59).withOpacity(0.1),
  /// Logout
  Future<void> logout() async {
    isLoading.value = true;
    try {
      await HazardDI.clearHazardCacheUseCase.clearAllCacheRelatedToHazard();
      await _logoutUseCase.call();
      isLoggedIn.value = false;
      _idleManager.disable(); // Logout бол idle унтраана
      print('logged out');
    } finally {
      isLoading.value = false;
    }
  }

  
  Future<void> autoLogout() async {
    await _endConnectionUseCase.call();
    isLoggedIn.value = false;
    _idleManager.disable();
  }

  // Энэ функц нь хэрэглэгч хуруугаа буулгах, өргөх, чирэх үйлдэл хийгдэх бүр дуудагдана.
  // Хэрэв тэр үед timer-ын хугацаа дуусаагүй буюу token устаагүй байвал timer-ыг reset хийнэ.
  // Хэрэв timer-ын хугацаа дууссан байхад хэрэглэгчийн id localStorage-д байхад үйлдэл хийвэл 
  // token-ыг дахин сэргээж өгнө. 
  //
  // Ерөнхий санаа нь хэрэглэгч апп-ыг хэрэглээгүй үед холболтыг хаах ба хэрэглэх үед нь 
  // шууд нээхийн тулд юм.
  void userActivityDetected() {
    bool isTimerEnabled = _idleManager.isTimerEnabled();
    if(isTimerEnabled){
      _idleManager.userActivityDetected();
      return;
    }
    recoverToken(false);
  }
}
