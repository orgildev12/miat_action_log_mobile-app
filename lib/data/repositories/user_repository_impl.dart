import 'package:action_log_app/data/data_sources/location/location_local_data.dart';
import 'package:action_log_app/data/data_sources/location/location_remote_data.dart';
import 'package:action_log_app/data/data_sources/user/user_local_data.dart';
import 'package:action_log_app/data/data_sources/user/user_remote_data.dart';
import 'package:action_log_app/domain/entities/location.dart';
import 'package:action_log_app/domain/repositories/location_repository.dart';
import 'package:action_log_app/application/mappers/location_mapper.dart';
import 'package:action_log_app/domain/repositories/user_repository.dart';
import 'package:action_log_app/models/location_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource local;
  final UserRemoteDataSource remote;

  UserRepositoryImpl({
    required this.local,
    required this.remote
  });
  
  @override
  Future<List<Location>> fetchUserInfo() async {
    try{
      final List<LocationModel> localModels = await local.getUserInfo();
      if (localModels.isNotEmpty) {
        // Convert each model to entity
        final List<Location> entities = [];
        for (var model in localModels) {
          final entity = model.toEntity();
          entities.add(entity);
        }
        
        return entities;
      }
      
      final List<LocationModel> remoteModels = await remote.fetchUserInfo();
      await local.saveUserInfo(remoteModels);
      return remoteModels.map((model) => model.toEntity()).toList();
    }
    catch(e) {
      rethrow;
    }
  }

  @override
  Future<void> clearLocationCache() async {
    try {
      await local.clearUser();
    } catch (e) {
      rethrow;
    }
  }
}