import 'package:action_log_app/domain/entities/hazard_type.dart';
import 'package:action_log_app/models/hazard_type_model.dart';

extension HazardTypeMapper on HazardTypeModel {
  HazardType toEntity() {
    return HazardType(
      id: id,
      shortCode: shortCode,
      nameEn: nameEn,
      nameMn: nameMn,
    );
  }
}