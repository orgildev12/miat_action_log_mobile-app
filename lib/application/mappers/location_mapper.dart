import 'package:action_log_app/domain/entities/location.dart';
import 'package:action_log_app/models/location_model.dart';

extension LocationMapper on LocationModel {
  Location toEntity() {
    return Location(
      id: id,
      nameEn: nameEn,
      nameMn: nameMn,
      locationGroupId: locationGroupId,
    );
  }
}