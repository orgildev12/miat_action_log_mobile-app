import 'dart:convert';

import 'package:action_log_app/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserLocalDataSource {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final String _key = 'user_cache';

  Future<void> saveUserInfo(UserModel user) async {
    try {
      final jsonString = jsonEncode(user.toJson());
      await _secureStorage.write(key: _key, value: jsonString);
    } catch (e) {
      throw Exception('Failed to save user: $e');
    }
  }

  Future<UserModel?> getUserInfo() async {
    try {
      final jsonString = await _secureStorage.read(key: _key);
      if (jsonString != null) {
        final Map<String, dynamic> json = jsonDecode(jsonString);
        return UserModel.fromJson(json);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }

  Future<void> clearUserInfo() async {
    try {
      await _secureStorage.delete(key: _key);
    } catch (e) {
      throw Exception('Failed to clear user: $e');
    }
  }
}