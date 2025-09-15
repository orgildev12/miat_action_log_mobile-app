import 'package:action_log_app/application/mappers/hazard_type_mapper.dart';
import 'package:action_log_app/data/data_sources/hazard_type/hazard_type_local_data.dart';
import 'package:action_log_app/data/data_sources/hazard_type/hazard_type_remote_data.dart';
import 'package:action_log_app/domain/entities/hazard_type.dart';
import 'package:action_log_app/domain/repositories/hazard_type_repository.dart';
import 'package:action_log_app/models/hazard_type_model.dart';

class HazardTypeRepositoryImpl implements HazardTypeRepository {
  final HazardTypeLocalDataSource local;
  final HazardTypeRemoteDataSource remote;

  HazardTypeRepositoryImpl({
    required this.local,
    required this.remote
  });
  @override
  Future<List<HazardType>> fetchHazardTypes() async {
    try{
      final List<HazardTypeModel> localModels = await local.getHazardTypes();
      if(localModels.isNotEmpty){
        final List<HazardType> entities = [];
        for(var model in localModels) {
          entities.add(model.toEntity());
        }
        return entities;
      }

      final HazardTypeModel remoteModel = await remote.fetchHazardType();
      await local.saveHazardTypes([remoteModel]);
      return [remoteModel.toEntity()];
    } 
    catch(e){
      rethrow;
    }
  }

  Future<void> clearHazardTypeCache() async {
    try {
      await local.clearHazardTypes();
    } catch (e) {
      rethrow;
    }
  }
}