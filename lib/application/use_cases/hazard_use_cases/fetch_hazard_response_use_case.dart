import 'package:action_log_app/domain/entities/response.dart';
import 'package:action_log_app/domain/repositories/hazard_repository.dart';

class FetchHazardResponseUseCase {
  final HazardRepository repository;
  
  FetchHazardResponseUseCase({required this.repository});

  Future<Response?> call(int hazardId) async {
    try {
      return await repository.fetchHazardResponse(hazardId);
    } catch (e) {
      throw Exception('Failed to fetch hazard response: $e');
    }
  }
}