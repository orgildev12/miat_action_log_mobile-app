import 'dart:io';

import 'package:action_log_app/core/error/exceptions.dart';
import 'package:action_log_app/core/network/api_client.dart';
import 'package:action_log_app/core/network/connectivity_checker.dart';
import 'package:action_log_app/models/hazard_model.dart';
import 'package:action_log_app/models/post_hazard_model.dart';

class HazardRemoteDataSource {
  final ConnectivityChecker connectivityChecker;
  final ApiClient apiClient;

  HazardRemoteDataSource({
    required this.connectivityChecker,
    required this.apiClient
  });

  // Hazard operations
  Future<List<HazardModel>> fetchHazards(int userId, String token) async {
    if (!await connectivityChecker.isConnected) {
      throw SocketException();
    }
    final headers = {
      'Authorization': 'Bearer $token',
    };
    print(headers);
    final result = await apiClient.get('/hazard/byUserId/$userId', headers: headers);

    try{
      if(result is! List){
        throw Exception('Invalid data format received');
      }
      return result.map((json) => HazardModel.fromJson(json as Map<String, dynamic>)).toList();
    } catch(e){
      if(e is ServerException){
        rethrow;
      }
      throw Exception('Unexpected error occurred: $e');
    }
  }

  Future<bool> postHazard({
    required PostHazardModel hazard, 
    String? token, 
    required bool isUserLoggedIn
    }) async {
    if (!await connectivityChecker.isConnected) {
      throw Exception('No internet connection');
    }

    if (isUserLoggedIn) {
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };
      try{
        await apiClient.post('/hazard/', hazard.toJson(true), headers: headers);
        return true;
        // response 300-аас дээш status code-той ирвэл expection болоод handle хийгдэнэ.
      } catch(e){
        if(e is ServerException){
          rethrow;
        }
        throw Exception('Failed to post hazard');
      }
    }

    try{
      await apiClient.post('/hazard/noLogin', hazard.toJson(false));
      return true;
    } catch(e){
      if(e is ServerException){
        rethrow;
      }
      throw Exception('Failed to post hazard');
    }
  }

  Future<bool> postHazardWithImage({
    required PostHazardModel hazard, 
    required List<File> images, 
    String? token, 
    required bool isUserLoggedIn,
    
    }) async {
    if (!await connectivityChecker.isConnected) {
      throw Exception('No internet connection');
    }

    if (isUserLoggedIn) {
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };
      try{
        final responseJson = await apiClient.post('/hazard/', hazard.toJson(true), headers: headers);
        int resultId = responseJson['id'];
        await uploadHazardImages(resultId, images, token);
        return true;
        // response 300-аас дээш status code-той ирвэл expection болоод handle хийгдэнэ.
      } catch(e){
        if(e is ServerException){
          rethrow;
        }
        print('error from remote data source');
        throw Exception(e);
      }
    }

    try{
      final responseJson = await apiClient.post('/hazard/noLogin', hazard.toJson(false));
      int resultId = responseJson['id'];
      await uploadHazardImages(resultId, images, token);
      return true;
    } catch(e){
      if(e is ServerException){
        rethrow;
      }
      throw Exception('Failed to post hazard');
    }
  }


  Future<void> uploadHazardImages(int hazardId, List<File> images, String? token) async {
    try{
      final headers = {
      'Authorization': 'Bearer $token',
    };
    print('just before call upload image');
    final result = await apiClient.postMultipart(
      '/hazard/$hazardId/images',
      files: images,
      headers: headers,
    );

    print('Upload result: $result');
    }catch(e){
      if(e is ServerException){
        rethrow;
      }
      throw Exception('Failed to post hazard');
    }
  }
}