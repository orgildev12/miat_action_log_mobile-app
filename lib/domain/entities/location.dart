class Location {
  final int id;
  final String nameEn;
  final String nameMn;
  final int? locationGroupId; // Made nullable to match backend

  Location({
    required this.id,
    required this.nameEn,
    required this.nameMn,
    this.locationGroupId, // Now optional
  });
}