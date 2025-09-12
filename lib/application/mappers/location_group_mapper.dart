import 'package:action_log_app/domain/entities/location_group.dart';
import 'package:action_log_app/domain/entities/location.dart';
import 'package:action_log_app/models/location_group_model.dart';
import 'package:action_log_app/models/location_model.dart';
import 'package:action_log_app/application/mappers/location_mapper.dart';

extension LocationGroupMapper on LocationGroupModel {
  LocationGroup toEntity({List<LocationModel>? locations}) {
    
    final Map<String, List<Location>> mappedLocations = {}; // Changed to Location
    
    if (locations != null) {
      for (var locationData in locations) {
        final groupId = locationData.locationGroupId.toString();
        
        if (mappedLocations[groupId] == null) {
          mappedLocations[groupId] = [];
        }
        mappedLocations[groupId]!.add(locationData.toEntity()); // Convert to entity
      }
    }
    
    return LocationGroup(
      id: id,
      nameEn: nameEn,
      nameMn: nameMn,
      locations: mappedLocations,
    );
  }
}