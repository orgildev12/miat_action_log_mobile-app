import 'package:action_log_app/domain/entities/location.dart';
import 'package:action_log_app/domain/repositories/location_repository.dart';

class FetchLocationsUseCase {
  final LocationRepository repository;
  FetchLocationsUseCase({required this.repository});

  Future<List<Location>> call({bool includeLocationsWithLGroup = false}) async {
    try {
      final locations = await repository.fetchLocations();
      
      // Business logic: filter locations based on location group association
      if (!includeLocationsWithLGroup) {
        // Return only locations WITHOUT location groups (null locationGroupId)
        final ungroupedLocations = locations.where((location) => location.locationGroupId == null).toList();
        return ungroupedLocations;
      }
      
      // Return all locations (with and without groups)
      return locations;
    } catch (e) {
      rethrow;
    }
  }
}