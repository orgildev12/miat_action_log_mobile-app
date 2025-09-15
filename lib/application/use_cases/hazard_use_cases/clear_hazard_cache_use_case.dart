import 'package:action_log_app/domain/repositories/hazard_repository.dart';

class ClearHazardCacheUseCase {
  final HazardRepository repository;
  
  ClearHazardCacheUseCase({required this.repository});

  Future<void> call() async {
    try {
      // Clear hazard cache
      await repository.clearHazardCache();
      
      // Also clear response cache since responses are helper data for hazards
      await repository.clearResponseCache();
    } catch (e) {
      throw Exception('Failed to clear hazard cache: $e');
    }
  }
}