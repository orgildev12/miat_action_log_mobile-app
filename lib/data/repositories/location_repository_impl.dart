import 'package:action_log_app/data/data_sources/location/location_local_data.dart';
import 'package:action_log_app/data/data_sources/location/location_remote_data.dart';
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
  
  @override
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
      
      final List<LocationModel> remoteModels = await remote.fetchLocations();
      await local.saveLocations(remoteModels);
      return remoteModels.map((model) => model.toEntity()).toList();
    }
    catch(e) {
      rethrow;
    }
  }

  @override
  Future<void> clearLocationCache() async {
    try {
      await local.clearLocations();
    } catch (e) {
      rethrow;
    }
  }
}