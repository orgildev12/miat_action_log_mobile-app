import 'package:action_log_app/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> fetchUserInfo();
  Future<void> saveTempUserInfoFromForm(String username, String email, String phoneNumber);
  Future<void> clearUserCache();
  Future<void> login(String email, String password);
  Future<void> logout();
}