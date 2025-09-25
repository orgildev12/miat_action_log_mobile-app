import 'package:action_log_app/domain/entities/hazard.dart';
import 'package:action_log_app/models/hazard_model_for_post.dart';

abstract class HazardRepository {
  // Hazard operations
  Future<List<Hazard>> fetchHazards();
  Future<void> postHazard(PostHazardModel hazard, {required bool isUserLoggedIn});
  Future<void> clearHazardCache();

}