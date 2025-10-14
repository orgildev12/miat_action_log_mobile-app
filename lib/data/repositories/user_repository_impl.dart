import 'package:action_log_app/data/data_sources/hazard/hazard_local_data.dart';
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

  final HazardLocalDataSource hazardLocal = HazardLocalDataSource();
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
      await hazardLocal.clearHazards();
    } catch (e) {
      rethrow;
    }
  }

  User createEmptyUser() {
    return User();
  }

  @override
  Future<User> fetchUserInfo() async {
    try {
      final UserModel? localModel = await local.getUserInfo();
      if (localModel != null && localModel.id != null) {
        return localModel.toEntity();
      }

      if (localModel != null && localModel.id == null) {
        final tempUser = await local.getUserInfo();
        if (tempUser != null) {
          return tempUser.toEntity();
        }
      }

      if (localModel == null) {
        return createEmptyUser();
      }

      final UserModel remoteModel = await remote.fetchUserInfo(localModel.id!);
      await local.saveUserInfo(remoteModel);
      return remoteModel.toEntity();
    } catch (e) {
      return createEmptyUser();
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