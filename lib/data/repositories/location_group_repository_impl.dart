import 'package:action_log_app/data/data_sources/location/location_group_local_data.dart';
import 'package:action_log_app/data/data_sources/location/location_group_remote_data.dart';
import 'package:action_log_app/domain/entities/location_group.dart';
import 'package:action_log_app/domain/repositories/location_group_repository.dart';
import 'package:action_log_app/application/mappers/location_group_mapper.dart';
import 'package:action_log_app/models/location_group_model.dart';

class LocationGroupRepositoryImpl implements LocationGroupRepository {
  final LocationGroupLocalDataSource local;
  final LocationGroupRemoteDataSource remote;

  LocationGroupRepositoryImpl({
    required this.local,
    required this.remote,
  });
  @override
  Future<List<LocationGroup>> fetchLocationGroups() async {
    try{
      final List<LocationGroupModel> localModels = await local.getLocationGroups();
      if (localModels.isNotEmpty) {
        // Convert each model to entity
        final List<LocationGroup> entities = [];
        for (var model in localModels) {
          final entity = model.toEntity();
          entities.add(entity);
        }
        
        return entities;
      }
      
      final LocationGroupModel remoteModel = await remote.fetchLocationGroup();
      await local.saveLocationGroups([remoteModel]);
      return [remoteModel.toEntity()];
    }
    catch(e) {
      rethrow;
    }
  }
}