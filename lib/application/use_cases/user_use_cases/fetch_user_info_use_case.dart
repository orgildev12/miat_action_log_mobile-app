import 'package:action_log_app/domain/entities/user.dart';
import 'package:action_log_app/domain/repositories/user_repository.dart';

class FetchUserInfoUseCase {
  final UserRepository repository;
  FetchUserInfoUseCase({required this.repository});

  Future <User> call() async {
    try {
      final userInfo = await repository.fetchUserInfo();
      return userInfo;
    } catch (e){
      rethrow;
    }
  }
}