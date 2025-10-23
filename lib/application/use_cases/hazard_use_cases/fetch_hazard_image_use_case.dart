import 'package:action_log_app/domain/entities/hazard_image_entity.dart';
import 'package:action_log_app/domain/repositories/hazard_repository.dart';
import 'package:action_log_app/domain/repositories/user_repository.dart';
import 'package:action_log_app/data/data_sources/user/user_local_data.dart';

class FetchHazardImageUseCase {
  final HazardRepository repository;
  final UserRepository userRepository;
  final UserLocalDataSource userLocalDataSource;
  FetchHazardImageUseCase({
    required this.repository,
    required this.userRepository,
    required this.userLocalDataSource,
  });

  Future<List<HazardImageEntity>> call({required int hazardId}) async {
    try {
      final user = await userRepository.fetchUserInfo();
      final token = await userLocalDataSource.getToken();
      if (user.id == null || token == null) {
        throw Exception('User ID or token is missing');
      }
      final hazardImages = await repository.fetchHazardImages(hazardId, token);
      return hazardImages;
    } catch (e) {
      rethrow;
    }
  }
}