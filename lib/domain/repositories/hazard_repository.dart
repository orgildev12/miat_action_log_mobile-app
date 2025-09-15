import 'package:action_log_app/domain/entities/hazard.dart';
import 'package:action_log_app/domain/entities/response.dart';

abstract class HazardRepository {
  // Hazard operations
  Future<List<Hazard>> fetchHazards();
  Future<void> postHazard(Hazard hazard);
  Future<void> clearHazardCache();
  
  // Response operations (part of hazard feature)
  Future<Response?> fetchHazardResponse(int hazardId);
  Future<void> postHazardResponse(Response response);
  Future<void> clearResponseCache();
}