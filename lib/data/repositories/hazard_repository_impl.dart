import 'package:action_log_app/application/mappers/hazard_mapper.dart';
import 'package:action_log_app/core/error/server_exception.dart';
import 'package:action_log_app/data/data_sources/hazard/hazard_local_data.dart';
import 'package:action_log_app/data/data_sources/hazard/hazard_remote_data.dart';
import 'package:action_log_app/domain/entities/hazard.dart';
import 'package:action_log_app/domain/repositories/hazard_repository.dart';
import 'package:action_log_app/models/hazard_model.dart';
import 'package:action_log_app/models/post_hazard_model.dart';

class HazardRepositoryImpl implements HazardRepository {
  final HazardLocalDataSource local;
  final HazardRemoteDataSource remote;

  HazardRepositoryImpl({
    required this.local,
    required this.remote
  });

  // Hazard operations
@override
Future<List<Hazard>> fetchHazards(int userId, String token) async {
  try {
    final List<HazardModel> localModels = await local.getHazards();
    if (localModels.isNotEmpty) {
      return localModels.map((model) => model.toEntity()).toList();
    }

    final List<HazardModel> remoteModels = await remote.fetchHazards(userId, token);
    await local.saveHazards(remoteModels);
    return remoteModels.map((model) => model.toEntity()).toList();
  } catch (e) {
    if(e is ServerException){
      rethrow;
    }
    throw Exception('Unexpected error occured: $e');
  }
}

  @override
  Future<bool> postHazard(PostHazardModel hazard, String? token, {required bool isUserLoggedIn}) async {
    try {
      final result = await remote.postHazard(hazard, token, isUserLoggedIn);
      return result;
    } catch (e) {
      if(e is ServerException){
        rethrow;
      }
      throw Exception('Unexpected error occured: $e');
    }
  }

  @override
  Future<void> clearHazardCache() async {
    try {
      await local.clearHazards();
    } catch (e) {
      rethrow;
    }
  }
  // ...existing code...
}