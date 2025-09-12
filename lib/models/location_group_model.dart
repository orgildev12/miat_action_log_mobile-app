class LocationGroupModel {
  final int id;
  final String nameEn;
  final String nameMn;

  LocationGroupModel({
    required this.id,
    required this.nameEn,
    required this.nameMn,
  });

  factory LocationGroupModel.fromJson(Map<String, dynamic> json) {
    return LocationGroupModel(
      id: json['id'],
      nameEn: json['name_en'],
      nameMn: json['name_mn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_en': nameEn,
      'name_mn': nameMn,
    };
  }
}