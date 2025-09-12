// Example of how to add a User feature DI
// TODO: Create these classes first

// import 'package:action_log_app/application/use_cases/login_use_case.dart';
// import 'package:action_log_app/application/use_cases/logout_use_case.dart';
// import 'package:action_log_app/domain/repositories/user_repository.dart';
// import 'package:action_log_app/data/reposities/user_repository_impl.dart';
// import 'package:action_log_app/data/data_sources/user_local_data.dart';
// import 'package:action_log_app/data/data_sources/user_remote_data.dart';
// import 'package:action_log_app/core/di/core_di.dart';

// User feature dependencies
// class UserDI {
//   static late final UserLocalDataSource _localDataSource;
//   static late final UserRemoteDataSource _remoteDataSource;
//   static late final UserRepository _repository;
//   static late final LoginUseCase _loginUseCase;
//   static late final LogoutUseCase _logoutUseCase;

//   static void setup() {
//     // Data sources
//     _localDataSource = UserLocalDataSource();
//     _remoteDataSource = UserRemoteDataSource(
//       connectivityChecker: CoreDI.connectivityChecker,
//       apiClient: CoreDI.apiClient,
//     );

//     // Repository
//     _repository = UserRepositoryImpl(
//       local: _localDataSource,
//       remote: _remoteDataSource,
//     );

//     // Use cases
//     _loginUseCase = LoginUseCase(repository: _repository);
//     _logoutUseCase = LogoutUseCase(repository: _repository);
//   }

//   // Getters
//   static UserRepository get repository => _repository;
//   static LoginUseCase get loginUseCase => _loginUseCase;
//   static LogoutUseCase get logoutUseCase => _logoutUseCase;
// }