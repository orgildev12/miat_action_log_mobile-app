import 'dart:convert';

import 'package:action_log_app/models/location_group_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationGroupLocalDataSource {
  final String _key = 'location_groups_cache';

  Future<void> saveLocationGroups(List<LocationGroupModel> locationGroups) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = locationGroups.map((locationGroup) => locationGroup.toJson()).toList();
      final jsonString = jsonEncode(jsonList);
      await prefs.setString(_key, jsonString);
    } catch (e) {
      throw Exception('Failed to save location groups: $e');
    }
  }

  Future<List<LocationGroupModel>> getLocationGroups() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_key);
      if (jsonString != null) {
        final List<dynamic> jsonList = jsonDecode(jsonString);
        return jsonList.map((json) => LocationGroupModel.fromJson(json)).toList();
      }
      return []; // Return empty list if no cached data
    } catch (e) {
      throw Exception('Failed to get location groups: $e');
    }
  }

  Future<void> clearLocationGroups() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_key);
    } catch (e) {
      throw Exception('Failed to clear location groups: $e');
    }
  }
}