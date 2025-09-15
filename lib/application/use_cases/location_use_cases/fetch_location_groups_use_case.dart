import 'package:action_log_app/domain/entities/location_group.dart';
import 'package:action_log_app/domain/repositories/location_group_repository.dart';
import 'package:action_log_app/domain/repositories/location_repository.dart';
import 'package:action_log_app/application/mappers/location_group_mapper.dart';
import 'package:action_log_app/models/location_group_model.dart';
import 'package:action_log_app/models/location_model.dart';

class FetchLocationGroupsUseCase {
  final LocationGroupRepository locationGroupRepository;
  final LocationRepository locationRepository;
  
  FetchLocationGroupsUseCase({
    required this.locationGroupRepository,
    required this.locationRepository,
  });

  Future<List<LocationGroup>> call({bool includeEmpty = false}) async {
    try {
      // This is a temporary approach - we'll fetch raw data and combine at use case level
      // In a better architecture, this would be done in the repository layer
      
      // Fetch location groups and locations separately
      final groups = await locationGroupRepository.fetchLocationGroups();
      final locations = await locationRepository.fetchLocations();
      
      // Convert locations to models for mapping
      final locationModels = locations.map((location) => LocationModel(
        id: location.id,
        nameEn: location.nameEn,
        nameMn: location.nameMn,
        locationGroupId: location.locationGroupId,
      )).toList();
      
      // Re-map groups with locations
      final groupsWithLocations = groups.map((group) {
        final groupModel = LocationGroupModel(
          id: group.id,
          nameEn: group.nameEn,
          nameMn: group.nameMn,
        );
        return groupModel.toEntity(locations: locationModels);
      }).toList();
      
      // Business logic: filter empty groups if requested
      if (!includeEmpty) {
        return groupsWithLocations.where((group) => 
          group.locations[group.id.toString()]?.isNotEmpty == true
        ).toList();
      }
      
      return groupsWithLocations;
    } catch (e) {
      // Handle or log the exception as needed
      rethrow; // Rethrow to let the caller handle it
    }
  }
}