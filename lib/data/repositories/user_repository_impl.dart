import 'package:action_log_app/data/data_sources/user/user_local_data.dart';
import 'package:action_log_app/data/data_sources/user/user_remote_data.dart';
import 'package:action_log_app/domain/entities/user.dart';
import 'package:action_log_app/domain/repositories/user_repository.dart';
import 'package:action_log_app/models/user_model.dart';
import 'package:action_log_app/application/mappers/user_mapper.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource local;
  final UserRemoteDataSource remote;

  UserRepositoryImpl({
    required this.local,
    required this.remote,
  });

  @override
  Future<void> login(String username, String password) async {
    try {
      // Call remote data source to authenticate and get user info/token
      final response = await remote.login(username, password);

      // Parse response
      if (response['success'] == true && response['data'] != null) {
        final userJson = response['data']['user'] as Map<String, dynamic>;
        final token = response['data']['token'] as String;

        // Save user info and token securely
        final userModel = UserModel.fromJson(userJson);
        await local.saveUserInfo(userModel);
        await local.saveToken(token);
      } else {
        throw Exception(response['message'] ?? 'Login failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await local.clearUserInfo();
      await local.clearToken();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> fetchUserInfo() async {
    try {
      final UserModel? localModel = await local.getUserInfo();
      if (localModel != null && localModel.id != null) {
        return localModel.toEntity();
      }

      // If localModel exists but id is null, try to build User from temp info
      if (localModel != null && localModel.id == null) {
        // Get temp user info from local storage
        final tempUser = await local.getUserInfo();
        if (tempUser != null) {
          return tempUser.toEntity();
        }
      }

      // If localModel is null, you may want to throw or handle accordingly
      if (localModel == null) {
        throw Exception('No user info found');
      }

      // Otherwise, fetch from remote
      final UserModel remoteModel = await remote.fetchUserInfo(localModel.id!);
      await local.saveUserInfo(remoteModel);
      return remoteModel.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveTempUserInfoFromForm(String username, String email, String phoneNumber) async {
    try {
      await local.saveTempUserInfoFromInput( username, email, phoneNumber);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> clearUserCache() async {
    try {
      await local.clearUserInfo();
    } catch (e) {
      rethrow;
    }
  }
}