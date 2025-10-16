import 'package:action_log_app/application/controllers/auth_controller.dart';
import 'package:action_log_app/application/use_cases/user_use_cases/end_connection_use_case.dart';
import 'package:action_log_app/application/use_cases/user_use_cases/recover_token_use_case.dart';
import 'package:action_log_app/core/di/core_di.dart';
import 'package:action_log_app/core/di/features/user_di.dart';

class AppDI {
  static late final AuthController authController;

  static void setup() {
    authController = AuthController(
      loginUseCase: UserDI.loginUseCase,
      logoutUseCase: UserDI.logoutUseCase,
      recoverTokenUseCase: RecoverTokenUseCase(UserDI.repository),
      endConnectionUseCase: EndConnectionUseCase(UserDI.repository),
      idleManager: CoreDI.idleManager,
    );
  }
}
