import 'package:action_log_app/domain/entities/user.dart';
import 'package:action_log_app/models/user_model.dart';

extension UserMapper on UserModel {
  User toEntity() {
    return User(
      id: id,
      username: username,
      fnameEn: fnameEn?.toUpperCase(),
      fnameMn: fnameMn?.toUpperCase(),
      lnameEn: lnameEn?.toUpperCase(),
      lnameMn: lnameMn?.toUpperCase(),
      email: email,
      phoneNumber: phoneNumber,
      password: password,
    );
  }
}