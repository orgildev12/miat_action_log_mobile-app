import 'package:action_log_app/domain/repositories/user_repository.dart';

class ClearUserInfoCacheUsecase {
  final UserRepository repository;
  
  ClearUserInfoCacheUsecase({
    required this.repository,
  });

  Future<void> call() async {
    try {
      await Future.wait([
        repository.clearUserCache(),
      ]);
    } catch (e) {
      throw Exception('Failed to clear location caches: $e');
    }
  }
}