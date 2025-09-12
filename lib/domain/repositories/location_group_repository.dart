import 'package:action_log_app/domain/entities/location_group.dart';

abstract class LocationGroupRepository {
  Future<List<LocationGroup>> fetchLocationGroups();
}

// abstraction defines what should be done, not how it is done.