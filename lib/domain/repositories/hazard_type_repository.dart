import 'package:action_log_app/domain/entities/hazard_type.dart';

abstract class HazardTypeRepository {
  Future<List<HazardType>> fetchHazardTypes();
  Future<void> clearHazardTypeCache();
}