class LocationModel {
  final int id;
  final String nameEn;
  final String nameMn;
  final int? locationGroupId; // Made nullable

  LocationModel({
    required this.id,
    required this.nameEn,
    required this.nameMn,
    this.locationGroupId, // Now optional
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      nameEn: json['name_en'],
      nameMn: json['name_mn'],
      locationGroupId: json['location_group_id'], // Can be null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_en': nameEn,
      'name_mn': nameMn,
      'location_group_id': locationGroupId,
    };
  }
}