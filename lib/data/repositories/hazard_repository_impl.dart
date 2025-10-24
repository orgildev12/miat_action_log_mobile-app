import 'dart:io';

import 'package:action_log_app/application/mappers/hazard_image_mapper.dart';
import 'package:action_log_app/application/mappers/hazard_mapper.dart';
import 'package:action_log_app/data/data_sources/hazard/hazard_local_data.dart';
import 'package:action_log_app/data/data_sources/hazard/hazard_remote_data.dart';
import 'package:action_log_app/domain/entities/hazard.dart';
import 'package:action_log_app/domain/entities/hazard_image_entity.dart';
import 'package:action_log_app/domain/repositories/hazard_repository.dart';
import 'package:action_log_app/models/hazard_image_model.dart';
import 'package:action_log_app/models/hazard_model.dart';
import 'package:action_log_app/models/post_hazard_model.dart';

class HazardRepositoryImpl implements HazardRepository {
  final HazardLocalDataSource local;
  final HazardRemoteDataSource remote;

  HazardRepositoryImpl({
    required this.local,
    required this.remote
  });

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
    rethrow;
  }
}

  @override
  Future<bool> postHazard(PostHazardModel hazard, String? token, {required bool isUserLoggedIn}) async {
    try {
      final result = await remote.postHazard(hazard: hazard, token:  token, isUserLoggedIn:  isUserLoggedIn);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> postHazardWithImage(PostHazardModel hazard, List<File> images, String? token, {required bool isUserLoggedIn}) async {
    try {
      final result = await remote.postHazardWithImage(hazard: hazard, images: images, token: token, isUserLoggedIn: isUserLoggedIn);
      return result;
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
  
  @override
  Future<void> uploadHazardImages(int hazardId, List<File> images, String token) async{
    try{
      final result = await remote.uploadHazardImages(hazardId, images, token);
      return result;
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<HazardImageEntity>> fetchHazardImages (int hazardId, String token) async {
    try{
      final List<HazardImageModel> localModels = await local.getHazardImages(hazardId);  
      if (localModels.isNotEmpty) {
        return localModels.map((model) => model.toEntity()).toList();
      }

      final List<HazardImageModel> remoteModels = await remote.fetchHazardImages(hazardId, token);
      await local.saveHazardImages(remoteModels);
      return remoteModels.map((model) => model.toEntity()).toList();
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<void> clearHazardImageCache() async {
    try {
      await local.clearHazardImages();
      await local.deleteAllHazardImagesOnDevice();
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<void> clearAllCacheRelatedToHazard() async {
    try {
      await local.clearAllHazardCache();
    } catch (e) {
      rethrow;
    }
  }
}