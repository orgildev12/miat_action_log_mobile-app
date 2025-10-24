import 'package:action_log_app/core/di/features/hazard_type_di.dart';
import 'package:action_log_app/core/di/features/location_di.dart';
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
      final response = await remote.login(username, password);

      if (response['success'] == true && response['data'] != null) {
        final userJson = response['data']['user'] as Map<String, dynamic>;
        final token = response['data']['token'] as String;
        userJson['password'] = password;
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
  Future<void> recoverToken() async {
    try {
      UserModel? localModel = await local.getUserInfo();

      // Хэрэв хэрэглэгч өмнө нь нэвтэрч байсан бол токенийг шууд сэргээж өгнө.
      if (localModel?.id != null && localModel?.password != null) {
        final pass = localModel?.password;
        final response = await remote.login(localModel!.username, pass!);

        if (response['success'] == true && response['data'] != null) {
          final token = response['data']['token'] as String;
          await local.saveToken(token);
          print('token restored');
          return;
        }else{
          // if(response.statusCode == 401){
            await logout();
            return;
          // }
          // Өмнө нь нэвтрэрч байсан хэрэглэгчийн мэдээлэл байгаа мөртлөө
          // тэр нь таарахгүй байвал мэдээллүүдийг устгана. 
          // (нууц үгээ солисон, эсвэл тухайн хэрэглэгч байхаа больсон гэсэн үг)
        }
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
      await hazardLocal.clearAllHazardCache();

      // Хөгжүүлэлтийн явцад locations болон hazard_types-д өөрчлөлт орох тул 
      // хөгжүүлэлт дуустал дараах 2 мөрийг үлдээе.
      await HazardTypeDI.clearHazardTypeCacheUseCase.call();
      await LocationDI.clearLocationCacheUseCase.call();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> endConnection() async {
    try {
      await local.clearToken();
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