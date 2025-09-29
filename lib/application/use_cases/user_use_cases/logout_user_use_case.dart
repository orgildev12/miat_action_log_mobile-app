import 'package:action_log_app/domain/repositories/user_repository.dart';

class LogoutUseCase {
  final UserRepository repository;

  LogoutUseCase({required this.repository});

  Future<void> call() async {
    // Implement logout logic here, e.g.:
    await repository.logout();
  }
}