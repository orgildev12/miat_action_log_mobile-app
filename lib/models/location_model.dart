class LocationModel {
  final int id;
  final String nameEn;
  final String nameMn;
  final int? locationGroupId; // Made nullable
  final String? groupNameEn; // Added field for group name in English
  final String? groupNameMn; // Added field for group name in Mongolian

  LocationModel({
    required this.id,
    required this.nameEn,
    required this.nameMn,
    this.locationGroupId, // Now optional
    this.groupNameEn, // Optional group name in English
    this.groupNameMn, // Optional group name in Mongolian
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      nameEn: json['name_en'],
      nameMn: json['name_mn'],
      locationGroupId: json['location_group_id'], // Can be null
      groupNameEn: json['group_name_en'], // Map group name in English
      groupNameMn: json['group_name_mn'], // Map group name in Mongolian
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_en': nameEn,
      'name_mn': nameMn,
      'location_group_id': locationGroupId,
      'group_name_en': groupNameEn, // Include group name in English
      'group_name_mn': groupNameMn, // Include group name in Mongolian
    };
  }
}