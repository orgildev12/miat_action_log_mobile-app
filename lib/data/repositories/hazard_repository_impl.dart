import 'package:action_log_app/application/mappers/hazard_mapper.dart';
import 'package:action_log_app/data/data_sources/hazard/hazard_local_data.dart';
import 'package:action_log_app/data/data_sources/hazard/hazard_remote_data.dart';
import 'package:action_log_app/domain/entities/hazard.dart';
import 'package:action_log_app/domain/entities/response.dart';
import 'package:action_log_app/domain/repositories/hazard_repository.dart';
import 'package:action_log_app/models/hazard_model.dart';
import 'package:action_log_app/models/response_model.dart';

class HazardRepositoryImpl implements HazardRepository {
  final HazardLocalDataSource local;
  final HazardRemoteDataSource remote;

  HazardRepositoryImpl({
    required this.local,
    required this.remote
  });

  // Hazard operations
  @override
  Future<List<Hazard>> fetchHazards() async {
    try{
      final List<HazardModel> localModels = await local.getHazards();
      if(localModels.isNotEmpty){
        final List<Hazard> entities = [];
        for(var model in localModels) {
          entities.add(model.toEntity());
        }
        return entities;
      }

      final List<HazardModel> remoteModels = await remote.fetchHazards();
      await local.saveHazards(remoteModels);
      return remoteModels.map((model) => model.toEntity()).toList();
    } 
    catch(e){
      rethrow;
    }
  }

  @override
  Future<void> postHazard(Hazard hazard) async {
    try {
      // Convert entity to model and post to remote
      final hazardModel = HazardModel(
        id: hazard.id,
        code: hazard.code ?? '',
        statusEn: hazard.statusEn ?? '',
        statusMn: hazard.statusMn ?? '',
        userId: hazard.userId,
        typeId: hazard.typeId,
        locationId: hazard.locationId,
        description: hazard.description,
        solution: hazard.solution,
        isPrivate: hazard.isPrivate,
        dateCreated: hazard.dateCreated ?? DateTime.now(),
      );
      
      await remote.postHazard(hazardModel);
      
      // Optionally save to local cache
      final cachedHazards = await local.getHazards();
      await local.saveHazards([...cachedHazards, hazardModel]);
    } catch (e) {
      rethrow;
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

  // Response operations (part of hazard feature)
  @override
  Future<Response?> fetchHazardResponse(int hazardId) async {
    try {
      // Try local cache first
      final localResponse = await local.getHazardResponse(hazardId);
      if (localResponse != null) {
        return _convertResponseModelToEntity(localResponse);
      }

      // Fetch from remote
      final remoteResponse = await remote.fetchHazardResponse(hazardId);
      if (remoteResponse != null) {
        await local.saveHazardResponse(remoteResponse);
        return _convertResponseModelToEntity(remoteResponse);
      }

      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> postHazardResponse(Response response) async {
    try {
      // Convert entity to model and post to remote
      final responseModel = _convertResponseEntityToModel(response);
      await remote.postHazardResponse(responseModel);
      
      // Update local cache
      await local.saveHazardResponse(responseModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> clearResponseCache() async {
    try {
      await local.clearResponseCache();
    } catch (e) {
      rethrow;
    }
  }

  // Helper methods for conversion
  Response _convertResponseModelToEntity(ResponseModel model) {
    return Response(
      hazardId: model.hazardId,
      isStarted: model.isStarted,
      responseBody: model.responseBody,
      isRequestApproved: model.isRequestApproved,
      isResponseConfirmed: model.isResponseConfirmed,
      dateUpdated: model.dateUpdated,
    );
  }

  ResponseModel _convertResponseEntityToModel(Response entity) {
    return ResponseModel(
      hazardId: entity.hazardId,
      currentStatus: '', // Default value since not in entity
      isStarted: entity.isStarted,
      responseBody: entity.responseBody ?? '',
      isRequestApproved: entity.isRequestApproved ?? 0,
      isResponseFinished: 0, // Default value
      responseFinishedDate: DateTime.now(),
      isCheckingResponse: 0, // Default value
      isResponseConfirmed: entity.isResponseConfirmed,
      isResponseDenied: 0, // Default value
      reasonToDeny: '', // Default value
      dateUpdated: entity.dateUpdated,
    );
  }
}