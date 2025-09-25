import 'package:action_log_app/domain/entities/hazard.dart';
import 'package:action_log_app/models/hazard_model.dart';

extension HazardMapper on HazardModel {
  Hazard toEntity() {
    return Hazard(
      code: code,
      statusEn: statusEn,
      statusMn: statusMn,
      typeNameEn: typeNameEn,
      typeNameMn: typeNameMn,
      locationNameEn: locationNameEn,
      locationNameMn: locationNameMn,
      description: description,
      solution: solution,
      dateCreated: dateCreated,
      isResponseConfirmed: isResponseConfirmed,
      responseBody: responseBody,
      isPrivate: isPrivate,
      dateUpdated: dateUpdated,
    );
  }
}