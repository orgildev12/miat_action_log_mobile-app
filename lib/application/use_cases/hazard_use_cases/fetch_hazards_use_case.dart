import 'package:action_log_app/domain/entities/hazard.dart';
import 'package:action_log_app/domain/repositories/hazard_repository.dart';

class FetchHazardsUseCase {
  final HazardRepository repository;
  FetchHazardsUseCase({required this.repository});

  Future<List<Hazard>> call() async {
    try {
      final hazards = await repository.fetchHazards();
      return hazards;
    } catch (e) {
      rethrow;
    }
  }
}