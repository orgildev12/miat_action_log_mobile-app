import 'dart:io';

import 'package:action_log_app/core/error/exceptions.dart';
import 'package:action_log_app/data/data_sources/user/user_local_data.dart';
import 'package:action_log_app/domain/repositories/hazard_repository.dart';
import 'package:action_log_app/models/post_hazard_model.dart';

class PostHazardUseCase {
  final HazardRepository repository;
  final UserLocalDataSource userLocalDataSource;

  PostHazardUseCase({
    required this.repository,
    required this.userLocalDataSource,
  });

  Future<bool> call(PostHazardModel hazard, List<File> images, {required bool isUserLoggedIn}) async {
    try {
      String? token;
      if (isUserLoggedIn) {
        token = await userLocalDataSource.getToken();
      }
      print('calling the use case');
      if(images.isNotEmpty){
        print('there is an image');
        final result = await repository.postHazardWithImage(hazard, images, token, isUserLoggedIn: isUserLoggedIn);
        return result;
      }
      print('executing no image');
      final result = await repository.postHazard(hazard, token, isUserLoggedIn: isUserLoggedIn);
      return result;
    } catch (e) {
      if(e is ServerException){
        rethrow;
      }
      throw Exception('Failed to post hazard: $e');
    }
  }
  
  Future<void> uploadHazardImages(int hazardId, List<File> images, {required bool isUserLoggedIn}) async{
    try{
      String? token;
      if (isUserLoggedIn) {    // TODO: add aditional logic later
        token = await userLocalDataSource.getToken();
      }
      final result = await repository.uploadHazardImages(hazardId, images, token!);
      return result;
    }catch (e){
      if(e is ServerException){
        rethrow;
      }
      throw Exception('Failed to post hazard: $e');
    }
  }

  
}