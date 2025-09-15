import 'package:action_log_app/domain/entities/hazard_type.dart';
import 'package:action_log_app/domain/repositories/hazard_type_repository.dart';

class FetchHazardTypesUseCase {
  final HazardTypeRepository repository;
  FetchHazardTypesUseCase({required this.repository});

  Future<List<HazardType>> call() async {
    try {
      final hazardTypes = await repository.fetchHazardTypes();
      return hazardTypes;
    } catch (e){
      rethrow;
    }
  }
}