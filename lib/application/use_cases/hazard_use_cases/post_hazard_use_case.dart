import 'package:action_log_app/domain/entities/hazard.dart';
import 'package:action_log_app/domain/repositories/hazard_repository.dart';

class PostHazardUseCase {
  final HazardRepository repository;
  
  PostHazardUseCase({required this.repository});

  Future<void> call(Hazard hazard) async {
    try {
      await repository.postHazard(hazard);
    } catch (e) {
      throw Exception('Failed to post hazard: $e');
    }
  }
}
