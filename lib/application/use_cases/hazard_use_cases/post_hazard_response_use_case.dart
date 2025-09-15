import 'package:action_log_app/domain/entities/response.dart';
import 'package:action_log_app/domain/repositories/hazard_repository.dart';

class PostHazardResponseUseCase {
  final HazardRepository repository;
  
  PostHazardResponseUseCase({required this.repository});

  Future<void> call(Response response) async {
    try {
      await repository.postHazardResponse(response);
    } catch (e) {
      throw Exception('Failed to post hazard response: $e');
    }
  }
}