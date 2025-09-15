import 'package:action_log_app/domain/repositories/hazard_repository.dart';

class ClearHazardCacheUseCase {
  final HazardRepository repository;
  
  ClearHazardCacheUseCase({required this.repository});

  Future<void> call() async {
    try {
      await repository.clearHazardCache();
    } catch (e) {
      throw Exception('Failed to clear hazard cache: $e');
    }
  }
}