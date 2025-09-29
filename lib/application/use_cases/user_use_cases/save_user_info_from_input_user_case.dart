import 'package:action_log_app/domain/repositories/user_repository.dart';

class SaveUserInfoFromInputUseCase {
  final UserRepository repository;
  
  SaveUserInfoFromInputUseCase({
    required this.repository,
  });

  Future<void> call(String username, String email, String phoneNumber) async {
    try {
      await Future.wait([
        repository.saveTempUserInfoFromForm(username, email, phoneNumber),
      ]);
    } catch (e) {
      throw Exception('Failed to save user info: $e');
    }
  }
}