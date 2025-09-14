import 'dart:convert';

import 'package:action_log_app/models/location_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocationLocalDataSource {
  final _storage = FlutterSecureStorage();
  final _key = 'locations_cache';

  Future<void> saveLocations(List<LocationModel> locations) async {
    final jsonList = locations.map((location) => location.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await _storage.write(key: _key, value: jsonString);
  }

  Future<List<LocationModel>> getLocations() async {
    final jsonString = await _storage.read(key: _key);
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => LocationModel.fromJson(json)).toList();
    }
    return []; // Return empty list if no cached data
  }

  Future<void> clearLocations() async {
    await _storage.delete(key: _key);
  }
}
