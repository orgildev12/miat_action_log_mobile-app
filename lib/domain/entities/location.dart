class Location {
  final int id;
  final String nameEn;
  final String nameMn;
  final int? locationGroupId;
  final String? groupNameEn; // Added property for English group name
  final String? groupNameMn; // Added property for Mongolian group name

  Location({
    required this.id,
    required this.nameEn,
    required this.nameMn,
    this.locationGroupId,
    this.groupNameEn, // Initialize optional group name in English
    this.groupNameMn, // Initialize optional group name in Mongolian
  });
}