import 'package:action_log_app/domain/repositories/location_group_repository.dart';
import 'package:action_log_app/domain/repositories/location_repository.dart';

class ClearLocationCacheUseCase {
  final LocationRepository repository;
  final LocationGroupRepository locationGroupRepository;
  
  ClearLocationCacheUseCase({
    required this.repository,
    required this.locationGroupRepository,
    
    });

  Future<void> call() async {
    try {
      await repository.clearLocationCache();
      await locationGroupRepository.clearLocationGroupCache();
    } catch (e) {
      throw Exception('Failed to clear location cache: $e');
    }
  }
}