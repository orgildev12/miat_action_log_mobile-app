import 'package:action_log_app/domain/repositories/user_repository.dart';

class EndConnectionUseCase {
  final UserRepository _userRepository;

  EndConnectionUseCase(this._userRepository);

  Future<void> call() async {
    await _userRepository.endConnection();
  }

  Future<bool> hasToken() async {
    final user = await _userRepository.fetchUserInfo();
    return user.id != null;
  }
}