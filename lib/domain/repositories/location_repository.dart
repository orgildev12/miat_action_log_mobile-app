import 'package:action_log_app/domain/entities/location.dart';

abstract class LocationRepository {
  Future<List<Location>> fetchLocationGroups();
}