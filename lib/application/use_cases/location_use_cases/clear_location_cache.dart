import 'package:action_log_app/domain/repositories/location_repository.dart';

class ClearLocationCacheUseCase {
  final LocationRepository locationRepository;
  
  ClearLocationCacheUseCase({
    required this.locationRepository,
  });

  Future<void> call() async {
    try {
      // Clear both location and location group caches since they're related
      await Future.wait([
        locationRepository.clearLocationCache(),
      ]);
    } catch (e) {
      throw Exception('Failed to clear location caches: $e');
    }
  }
}