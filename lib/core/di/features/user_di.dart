import 'package:action_log_app/application/use_cases/user_use_cases/clear_user_info_use_case.dart';
import 'package:action_log_app/application/use_cases/user_use_cases/fetch_user_info_use_case.dart';
import 'package:action_log_app/application/use_cases/user_use_cases/login_user_case.dart';
import 'package:action_log_app/application/use_cases/user_use_cases/logout_user_use_case.dart';
import 'package:action_log_app/application/use_cases/user_use_cases/recover_token_use_case.dart';
import 'package:action_log_app/application/use_cases/user_use_cases/save_user_info_from_input_user_case.dart';
import 'package:action_log_app/core/di/core_di.dart';
import 'package:action_log_app/data/data_sources/user/user_local_data.dart';
import 'package:action_log_app/data/data_sources/user/user_remote_data.dart';
import 'package:action_log_app/data/repositories/user_repository_impl.dart';
import 'package:action_log_app/domain/repositories/user_repository.dart';
import 'package:action_log_app/application/controllers/auth_controller.dart';
import 'package:action_log_app/application/use_cases/user_use_cases/end_connection_use_case.dart';

class UserDI {
  // Data sources
  static late final UserLocalDataSource _localDataSource;
  static late final UserRemoteDataSource _remoteDataSource;

  // Repository
  static late final UserRepository _repository;

  // Use cases
  static late final FetchUserInfoUseCase _fetchUserInfoUseCase;
  static late final SaveUserInfoFromInputUseCase _saveUserInfoFromInput;
  static late final ClearUserInfoCacheUsecase _clearUserInfoCacheUsecase;
  static late final LoginUseCase _loginUseCase;
  static late final LogoutUseCase _logoutUseCase;

  // Application layer
  static late final AuthController authController;

  static void setup() {
    // Data sources
    _localDataSource = UserLocalDataSource();
    _remoteDataSource = UserRemoteDataSource(
      connectivityChecker: CoreDI.connectivityChecker,
      apiClient: CoreDI.apiClient,
    );

    // Repository
    _repository = UserRepositoryImpl(
      local: _localDataSource,
      remote: _remoteDataSource,
    );

    // Use cases
    _fetchUserInfoUseCase = FetchUserInfoUseCase(repository: _repository);
    _saveUserInfoFromInput = SaveUserInfoFromInputUseCase(repository: _repository);
    _clearUserInfoCacheUsecase = ClearUserInfoCacheUsecase(repository: _repository);
    _loginUseCase = LoginUseCase(repository: _repository);
    _logoutUseCase = LogoutUseCase(repository: _repository);

    // AuthController with IdleManager
    authController = AuthController(
      loginUseCase: _loginUseCase,
      logoutUseCase: _logoutUseCase,
      recoverTokenUseCase: RecoverTokenUseCase(_repository),
      endConnectionUseCase: EndConnectionUseCase(_repository),
      idleManager: CoreDI.idleManager,
    );
  }

  // Getters
  static UserRepository get repository => _repository;
  static UserLocalDataSource get localDataSource => _localDataSource;
  static FetchUserInfoUseCase get fetchUserInfoUseCase => _fetchUserInfoUseCase;
  static SaveUserInfoFromInputUseCase get saveUserInfoFromInput => _saveUserInfoFromInput;
  static ClearUserInfoCacheUsecase get clearUserInfoCacheUsecase => _clearUserInfoCacheUsecase;
  static LoginUseCase get loginUseCase => _loginUseCase;
  static LogoutUseCase get logoutUseCase => _logoutUseCase;
  static AuthController get controller => authController;
}
