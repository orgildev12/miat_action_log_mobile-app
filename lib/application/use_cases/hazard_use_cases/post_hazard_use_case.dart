import 'package:action_log_app/data/data_sources/user/user_local_data.dart';
import 'package:action_log_app/domain/repositories/hazard_repository.dart';
import 'package:action_log_app/models/post_hazard_model.dart';

class PostHazardUseCase {
  final HazardRepository repository;
  final UserLocalDataSource userLocalDataSource;

  PostHazardUseCase({
    required this.repository,
    required this.userLocalDataSource,
  });

  Future<void> call(PostHazardModel hazard, {required bool isUserLoggedIn}) async {
    try {
      String? token;
      if (isUserLoggedIn) {
        token = await userLocalDataSource.getToken();
      }
      await repository.postHazard(hazard, token, isUserLoggedIn: isUserLoggedIn);
    } catch (e) {
      throw Exception('Failed to post hazard: $e');
    }
  }
}