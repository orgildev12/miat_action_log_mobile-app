import 'dart:convert';

import 'package:action_log_app/models/hazard_model.dart';
import 'package:action_log_app/models/response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HazardLocalDataSource {
  final String _hazardsKey = 'hazards_cache';
  final String _responsesKey = 'responses_cache';

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

  Future<void> clearAllCache() async {
    try {
      await clearHazards();
      await clearResponseCache();
    } catch (e) {
      throw Exception('Failed to clear all cache: $e');
    }
  }
}