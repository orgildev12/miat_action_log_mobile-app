import 'package:action_log_app/domain/entities/hazard.dart';
import 'package:action_log_app/domain/repositories/hazard_repository.dart';
import 'package:action_log_app/domain/repositories/user_repository.dart';
import 'package:action_log_app/data/data_sources/user/user_local_data.dart';

class FetchHazardsUseCase {
  final HazardRepository repository;
  final UserRepository userRepository;
  final UserLocalDataSource userLocalDataSource;

  FetchHazardsUseCase({
    required this.repository,
    required this.userRepository,
    required this.userLocalDataSource,
  });

  Future<List<Hazard>> call() async {
    try {
      final user = await userRepository.fetchUserInfo();
      final token = await userLocalDataSource.getToken();
      if (user.id == null || token == null) {
        throw Exception('User ID or token is missing');
      }
      final hazards = await repository.fetchHazards(user.id!, token);
      return hazards;
    } catch (e) {
      rethrow;
    }
  }
}