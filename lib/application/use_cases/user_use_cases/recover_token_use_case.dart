import 'package:action_log_app/domain/repositories/user_repository.dart';

class RecoverTokenUseCase {
  final UserRepository _userRepository;
  RecoverTokenUseCase(this._userRepository);

  Future<void> call() async {
    await _userRepository.recoverToken();
  }
}