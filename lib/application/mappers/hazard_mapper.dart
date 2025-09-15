

import 'package:action_log_app/domain/entities/hazard.dart';
import 'package:action_log_app/domain/entities/response.dart';
import 'package:action_log_app/models/hazard_model.dart';
import 'package:action_log_app/models/location_model.dart';
import 'package:action_log_app/models/hazard_type_model.dart';

extension HazardMapper on HazardModel {
  Hazard toEntity({
    Response? response,
    List<LocationModel>? locations,     // Pass list of all locations
    List<HazardTypeModel>? hazardTypes, // Pass list of all hazard types
  }) {
    // Look up type names by typeId
    String typeNameEn = 'Unknown Type';
    String typeNameMn = 'Үл мэдэгдэх төрөл';
    if (hazardTypes != null) {
      try {
        final hazardType = hazardTypes.firstWhere((type) => type.id == typeId);
        typeNameEn = hazardType.nameEn;
        typeNameMn = hazardType.nameMn;
      } catch (e) {
        // Keep default values if not found
      }
    }

    // Look up location names by locationId
    String locationNameEn = 'Unknown Location';
    String locationNameMn = 'Үл мэдэгдэх байршил';
    if (locations != null) {
      try {
        final location = locations.firstWhere((loc) => loc.id == locationId);
        locationNameEn = location.nameEn;
        locationNameMn = location.nameMn;
      } catch (e) {
        // Keep default values if not found
      }
    }

    return Hazard(
      id: id,
      code: code,
      userId: userId,
      userName: userName,
      email: email,
      phoneNumber: phoneNumber,
      typeId: typeId,
      typeNameEn: typeNameEn,           // Enriched: Pulled from hazardTypes by typeId
      typeNameMn: typeNameMn,           // Enriched: Pulled from hazardTypes by typeId
      locationId: locationId,
      locationNameEn: locationNameEn,   // Enriched: Pulled from locations by locationId
      locationNameMn: locationNameMn,   // Enriched: Pulled from locations by locationId
      description: description,
      solution: solution,
      isPrivate: isPrivate,
      dateCreated: dateCreated,
      responseOfHazard: response,
    );
  }
}