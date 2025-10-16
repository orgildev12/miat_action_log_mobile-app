import 'package:action_log_app/domain/repositories/user_repository.dart';

class LoginUseCase {
  final UserRepository repository;

  LoginUseCase({required this.repository});

  Future<void> call(String email, String password) async {
    await repository.login(email, password);
  }
}