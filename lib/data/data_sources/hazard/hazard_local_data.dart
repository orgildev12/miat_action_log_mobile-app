import 'dart:convert';
import 'dart:io';

import 'package:action_log_app/models/hazard_image_model.dart';
import 'package:action_log_app/models/hazard_model.dart';
import 'package:action_log_app/models/response_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HazardLocalDataSource {
  final String _hazardsKey = 'hazards_cache';
  final String _responsesKey = 'responses_cache';
  final String _hazardImageKey = 'hazard_image_cache';

  // Hazard operations
  Future<void> saveHazards(List<HazardModel> hazards) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = hazards.map((hazard) => hazard.toJson()).toList();
      final jsonString = jsonEncode(jsonList);
      await prefs.setString(_hazardsKey, jsonString);
    } catch (e) {
      throw Exception('Failed to save hazards: $e');
    }
  }

  Future<List<HazardModel>> getHazards() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_hazardsKey);
      if(jsonString != null) {
        final List<dynamic> jsonList = jsonDecode(jsonString);
        return jsonList.map((json) => HazardModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to get hazards: $e');
    }
  }

  Future<void> clearHazards() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_hazardsKey);
      // await prefs.remove(_responsesKey);
    } catch (e) {
      throw Exception('Failed to clear hazards: $e');
    }
  }

  // Response operations (part of hazard feature)
  Future<void> saveHazardResponse(ResponseModel response) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Get existing responses
      final existingResponses = await _getAllResponses();
      
      // Update or add the response
      final updatedResponses = Map<String, ResponseModel>.from(existingResponses);
      updatedResponses[response.hazardId.toString()] = response;
      
      // Save back to preferences
      final responseMap = updatedResponses.map(
        (key, value) => MapEntry(key, value.toJson())
      );
      final jsonString = jsonEncode(responseMap);
      await prefs.setString(_responsesKey, jsonString);
    } catch (e) {
      throw Exception('Failed to save hazard response: $e');
    }
  }

  Future<ResponseModel?> getHazardResponse(int hazardId) async {
    try {
      final responses = await _getAllResponses();
      return responses[hazardId.toString()];
    } catch (e) {
      throw Exception('Failed to get hazard response: $e');
    }
  }

  Future<Map<String, ResponseModel>> _getAllResponses() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_responsesKey);
      if (jsonString != null) {
        final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
        return jsonMap.map(
          (key, value) => MapEntry(key, ResponseModel.fromJson(value))
        );
      }
      return {};
    } catch (e) {
      throw Exception('Failed to get all responses: $e');
    }
  }

  Future<void> clearResponseCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_responsesKey);
    } catch (e) {
      throw Exception('Failed to clear response cache: $e');
    }
  }

  Future<void> clearAllHazardCache() async {
    try {
      await clearHazards();
      await clearResponseCache();
      await clearHazardImages();
      await deleteAllHazardImagesOnDevice();
    } catch (e) {
      throw Exception('Failed to clear all cache: $e');
    }
  }

Future<void> saveHazardImages(List<HazardImageModel> newImages) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final appDir = await getApplicationDocumentsDirectory();

    final cachedJson = prefs.getString('_hazardImageKey');
    final List<HazardImageModel> allImages = cachedJson != null
        ? (jsonDecode(cachedJson) as List)
            .map((e) => HazardImageModel.fromJson(e))
            .toList()
        : [];

    for (var image in newImages) {
      final filePath = File('${appDir.path}/hazard_image_${image.id}.png');

      if (!await filePath.exists()) {
        // Decode Base64 and save to disk
        final bytes = base64Decode(image.imageData);
        await filePath.writeAsBytes(bytes);
        print('Created new image file: ${filePath.path}');
      } else {
        print('Image already exists, skipping write: ${filePath.path}');
      }

      image.imageData = filePath.path;

      if (!allImages.any((img) => img.id == image.id)) {
        allImages.add(image);
      }
    }

    final jsonList = allImages.map((image) => image.toJson()).toList();
    await prefs.setString('_hazardImageKey', jsonEncode(jsonList));

    print('Saved ${newImages.length} new images, total cached: ${allImages.length}');
  } catch (e) {
    throw Exception('Failed to save hazard images: $e');
  }
}


  Future<List<HazardImageModel>> getHazardImages(int hazardId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedJson = prefs.getString('_hazardImageKey');

      if (cachedJson != null) {
        final List<dynamic> jsonList = jsonDecode(cachedJson);

        final models = jsonList
            .map((json) => HazardImageModel.fromJson(json))
            .where((image) => image.hazardId == hazardId)
            .toList();

        final List<HazardImageModel> existingFiles = [];

        for (var model in models) {
          final file = File(model.imageData);
          if (await file.exists()) {
            existingFiles.add(model);
          } else {
            // Хадгалсан зурагнууд устсан байвал тэр чигт нь устгаад, хоосон list явуулна
            // Хэрэв хоосон list ирвэл дараагийн функцууд remote data source-ийг ашиглана.
            clearHazardImages();
            return [];
          }
        }
        return existingFiles;
      }

      return [];
    } catch (e) {
      throw Exception('Failed to get hazard images: $e');
    }
  }


  Future<void> clearHazardImages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_hazardImageKey);
    } catch (e) {
      throw Exception('Failed to clear hazards: $e');
    }
  }

  Future<void> deleteAllHazardImagesOnDevice() async {
    final appDir = await getApplicationDocumentsDirectory();
    final dir = Directory(appDir.path);

    // List all files in the directory
    final files = dir.listSync();

    for (final file in files) {
      if (file is File && file.path.contains('hazard_image_')) {
        try {
          await file.delete();
          print('Deleted: ${file.path}');
        } catch (e) {
          print('Failed to delete ${file.path}: $e');
        }
      }
    }
  }
}