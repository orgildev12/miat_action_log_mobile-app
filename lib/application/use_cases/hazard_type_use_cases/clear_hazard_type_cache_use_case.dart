import 'package:action_log_app/domain/repositories/hazard_type_repository.dart';

class ClearHazardTypeCacheUseCase {
  final HazardTypeRepository repository;

  ClearHazardTypeCacheUseCase({required this.repository});

  Future<void> call() async {
    try {
      await repository.clearHazardTypeCache();
    } catch (e) {
      throw Exception('Failed to clear hazard type cache: $e');
    }
  }
}