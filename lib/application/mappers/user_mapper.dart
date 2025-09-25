import 'package:action_log_app/domain/entities/user.dart';
import 'package:action_log_app/models/user_model.dart';

extension UserMapper on UserModel {
  User toEntity() {
    return User(
      id: id,
      username: username,
      fnameEn: fnameEn,
      fnameMn: fnameMn,
      lnameEn: lnameEn,
      lnameMn: lnameMn,
      email: email,
      phoneNumber: phoneNumber,
    );
  }
}