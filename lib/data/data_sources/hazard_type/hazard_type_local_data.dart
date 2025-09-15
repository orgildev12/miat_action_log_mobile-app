import 'dart:convert';

import 'package:action_log_app/models/hazard_type_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HazardTypeLocalDataSource {
  final _key = 'hazard_types_cache';

  Future<void> saveHazardTypes(List<HazardTypeModel> hazardTypes) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = hazardTypes.map((hazardType) => hazardType.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await prefs.setString(_key, jsonString);
  }

  Future<List<HazardTypeModel>> getHazardTypes() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if(jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => HazardTypeModel.fromJson(json)).toList();
    }
    return [];
  }

  Future<void> clearHazardTypes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}