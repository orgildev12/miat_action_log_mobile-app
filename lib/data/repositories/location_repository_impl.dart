import 'package:action_log_app/data/data_sources/location_local_data.dart';
import 'package:action_log_app/data/data_sources/location_remote_data.dart';
import 'package:action_log_app/domain/entities/location.dart';
import 'package:action_log_app/domain/repositories/location_repository.dart';
import 'package:action_log_app/application/mappers/location_mapper.dart';
import 'package:action_log_app/models/location_model.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationLocalDataSource local;
  final LocationRemoteDataSource remote;

  LocationRepositoryImpl({
    required this.local,
    required this.remote
  });

  Future<List<Location>> fetchLocations() async {
    try{
      final List<LocationModel> localModels = await local.getLocations();
      if (localModels.isNotEmpty) {
        // Convert each model to entity
        final List<Location> entities = [];
        for (var model in localModels) {
          final entity = model.toEntity();
          entities.add(entity);
        }
        
        return entities;
      }
      
      final LocationModel remoteModel = await remote.fetchLocations();
      await local.saveLocations([remoteModel]);
      return [remoteModel.toEntity()];
    }
    catch(e) {
      rethrow;
    }
  }
}