import 'dart:io';

import 'package:action_log_app/domain/entities/hazard.dart';
import 'package:action_log_app/models/post_hazard_model.dart';

abstract class HazardRepository {
  // Hazard operations
  Future<List<Hazard>> fetchHazards(int userId, String token);
  Future<bool> postHazard(PostHazardModel hazard, String? token, {required bool isUserLoggedIn});
  Future<bool> postHazardWithImage(PostHazardModel hazard, List<File> images, String? token, {required bool isUserLoggedIn});
  Future<void> clearHazardCache();
  Future<void> uploadHazardImages(int hazardId, List<File> images, String token);

}