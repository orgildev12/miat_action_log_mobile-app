import 'dart:convert';

import 'package:action_log_app/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserLocalDataSource {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final String _key = 'user_cache';
  final String _tokenKey = 'user_token';

  Future<void> saveToken(String token) async {
    try {
      await _secureStorage.write(key: _tokenKey, value: token);
    } catch (e) {
      throw Exception('Failed to save token: $e');
    }
  }

  Future<String?> getToken() async {
    try {
      final token = await _secureStorage.read(key: _tokenKey);
      if(token == null || token.isEmpty) {
        return null;
      }
      return token;
    } catch (e) {
      throw Exception('Failed to get token: $e');
    }
  }

  Future<void> clearToken() async {
    try {
      await _secureStorage.delete(key: _tokenKey);
    } catch (e) {
      throw Exception('Failed to clear token: $e');
    }
  }

  Future<void> saveUserInfo(UserModel user) async {
    try {
      final jsonString = jsonEncode(user.toJson());
      await _secureStorage.write(key: _key, value: jsonString);
    } catch (e) {
      throw Exception('Failed to save user: $e');
    }
  }

  Future<void> saveTempUserInfoFromInput(String username, String email, String phoneNumber) async {
    try {
      final user = UserModel(
        username: username,
        email: email,
        phoneNumber: phoneNumber,
      );
      final jsonString = jsonEncode(user.toJson());
      // print(jsonString);
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