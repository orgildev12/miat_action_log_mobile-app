class HazardTypeModel {
  final int id;
  final String shortCode;
  final String nameEn;
  final String nameMn;
  final int lastIndex;

  HazardTypeModel({
    required this.id,
    required this.shortCode,
    required this.nameEn,
    required this.nameMn,
    required this.lastIndex
  });

  factory HazardTypeModel.fromJson(Map<String, dynamic> json) {
    return HazardTypeModel(
      id: json['id'],
      shortCode: json['short_code'],
      nameEn: json['name_en'],
      nameMn: json['name_mn'],
      lastIndex: json['last_index']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'short_code': shortCode,
      'name_en': nameEn,
      'name_mn': nameMn,
      'last_index': lastIndex
    };
  }
}