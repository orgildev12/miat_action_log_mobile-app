import 'dart:convert';

import 'package:action_log_app/models/location_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationLocalDataSource {
  final String _key = 'locations_cache';

  Future<void> saveLocations(List<LocationModel> locations) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = locations.map((location) => location.toJson()).toList();
      final jsonString = jsonEncode(jsonList);
      await prefs.setString(_key, jsonString);
    } catch (e) {
      throw Exception('Failed to save locations: $e');
    }
  }

  Future<List<LocationModel>> getLocations() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_key);
      if (jsonString != null) {
        final List<dynamic> jsonList = jsonDecode(jsonString);
        return jsonList.map((json) => LocationModel.fromJson(json)).toList();
      }
      return []; // Return empty list if no cached data
    } catch (e) {
      throw Exception('Failed to get locations: $e');
    }
  }

  Future<void> clearLocations() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_key);
    } catch (e) {
      throw Exception('Failed to clear locations: $e');
    }
  }
}
