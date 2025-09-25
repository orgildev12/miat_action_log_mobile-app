import 'package:action_log_app/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> fetchLocations();
  Future<void> clearLocationCache();
}