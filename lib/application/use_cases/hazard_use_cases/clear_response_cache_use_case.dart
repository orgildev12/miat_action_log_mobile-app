import 'package:action_log_app/domain/repositories/hazard_repository.dart';

class ClearResponseCacheUseCase {
  final HazardRepository repository;
  
  ClearResponseCacheUseCase({required this.repository});

  Future<void> call() async {
    try {
      await repository.clearResponseCache();
    } catch (e) {
      throw Exception('Failed to clear response cache: $e');
    }
  }
}