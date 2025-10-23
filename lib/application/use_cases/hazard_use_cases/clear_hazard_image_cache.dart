import 'package:action_log_app/domain/repositories/hazard_repository.dart';

class ClearHazardImageCache {
  final HazardRepository hazardRepository;

  ClearHazardImageCache({required this.hazardRepository});

  Future<void> call() async {
    try {
      await hazardRepository.clearHazardImageCache();
    } catch (e) {
      throw Exception('Failed to clear hazard cache: $e');
    }
  }
}