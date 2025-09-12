import 'package:action_log_app/domain/entities/location_group.dart';
import 'package:action_log_app/domain/repositories/location_group_repository.dart';

class FetchLocationGroupsUseCase {
  final LocationGroupRepository repository;
  FetchLocationGroupsUseCase({required this.repository});

  Future<List<LocationGroup>> call({bool includeEmpty = false}) async {
    try {
      final groups = await repository.fetchLocationGroups();
      
      // Business logic: filter empty groups if requested
      if (!includeEmpty) {
        return groups.where((group) => group.locations.isNotEmpty).toList();
      }
      
      return groups;
    } catch (e) {
      // Handle or log the exception as needed
      rethrow; // Rethrow to let the caller handle it
    }
  }
}