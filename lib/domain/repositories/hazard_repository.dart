import 'package:action_log_app/domain/entities/hazard.dart';
import 'package:action_log_app/models/post_hazard_model.dart';

abstract class HazardRepository {
  // Hazard operations
  Future<List<Hazard>> fetchHazards(int userId, String token);
  Future<void> postHazard(PostHazardModel hazard, String? token, {required bool isUserLoggedIn});
  Future<void> clearHazardCache();

}