class HazardTypeModel {
  final int id;
  final String shortCode;
  final String nameEn;
  final String nameMn;
  final int isPrivate;

  HazardTypeModel({
    required this.id,
    required this.shortCode,
    required this.nameEn,
    required this.nameMn,
    required this.isPrivate,
  });

  factory HazardTypeModel.fromJson(Map<String, dynamic> json) {
    return HazardTypeModel(
      id: json['id'],
      shortCode: json['short_code'],
      nameEn: json['name_en'],
      nameMn: json['name_mn'],
      isPrivate: json['isPrivate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'short_code': shortCode,
      'name_en': nameEn,
      'name_mn': nameMn,
      'isPrivate': isPrivate,
    };
  }
}