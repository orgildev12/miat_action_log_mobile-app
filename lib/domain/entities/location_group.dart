import 'package:action_log_app/domain/entities/location.dart';

class LocationGroup {
  final int id;
  final String nameEn;
  final String nameMn;
  final Map<String, List<Location>> locations;

  LocationGroup({
    required this.id,
    required this.nameEn,
    required this.nameMn,
    required this.locations,
  });
}