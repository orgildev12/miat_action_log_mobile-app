import 'package:action_log_app/domain/repositories/location_repository.dart';
import 'package:action_log_app/domain/repositories/location_group_repository.dart';

class ClearLocationCacheUseCase {
  final LocationRepository locationRepository;
  final LocationGroupRepository locationGroupRepository;
  
  ClearLocationCacheUseCase({
    required this.locationRepository,
    required this.locationGroupRepository,
  });

  Future<void> call() async {
    try {
      // Clear both location and location group caches since they're related
      await Future.wait([
        locationRepository.clearLocationCache(),
        locationGroupRepository.clearLocationGroupCache(),
      ]);
    } catch (e) {
      throw Exception('Failed to clear location caches: $e');
    }
  }
}