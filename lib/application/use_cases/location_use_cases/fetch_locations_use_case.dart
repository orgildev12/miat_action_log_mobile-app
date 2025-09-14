import 'package:action_log_app/domain/entities/location.dart';
import 'package:action_log_app/domain/repositories/location_repository.dart';

class FetchLocationsUseCase {
  final LocationRepository repository;
  FetchLocationsUseCase({required this.repository});

  Future<List<Location>> call() async {
    try {
      final locations = await repository.fetchLocations();
      return locations;
    } catch (e) {
      rethrow;
    }
  }
}