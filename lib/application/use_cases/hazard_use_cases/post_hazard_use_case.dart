import 'package:action_log_app/domain/repositories/hazard_repository.dart';
import 'package:action_log_app/models/hazard_model_for_post.dart';

class PostHazardUseCase {
  final HazardRepository repository;
  
  PostHazardUseCase({required this.repository});

  Future<void> call(PostHazardModel hazard, {required bool isUserLoggedIn}) async {
    try {
      await repository.postHazard(hazard, isUserLoggedIn: isUserLoggedIn);
    } catch (e) {
      throw Exception('Failed to post hazard: $e');
    }
  }
}
