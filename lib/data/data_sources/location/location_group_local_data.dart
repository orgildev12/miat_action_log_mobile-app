import 'dart:convert';

import 'package:action_log_app/models/location_group_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocationGroupLocalDataSource {
  final _storage = FlutterSecureStorage();
  final _key = 'location_groups_cache';

  Future<void> saveLocationGroups(List<LocationGroupModel> locationGroups) async {
    final jsonList = locationGroups.map((locationGroup) => locationGroup.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await _storage.write(key: _key, value: jsonString);
  }

  Future<List<LocationGroupModel>> getLocationGroups() async {
    final jsonString = await _storage.read(key: _key);
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => LocationGroupModel.fromJson(json)).toList();
    }
    return []; // Return empty list if no cached data
  }

  Future<void> clearLocationGroups() async {
    await _storage.delete(key: _key);
  }
}