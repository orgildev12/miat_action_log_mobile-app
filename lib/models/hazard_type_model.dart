class HazardTypeModel {
  final int id;
  final String shortCode;
  final String nameEn;
  final String nameMn;
  final int isPrivate;
  final int lastIndex; // <-- Add this field

  HazardTypeModel({
    required this.id,
    required this.shortCode,
    required this.nameEn,
    required this.nameMn,
    required this.isPrivate,
    required this.lastIndex, // <-- Add to constructor
  });

  factory HazardTypeModel.fromJson(Map<String, dynamic> json) {
    return HazardTypeModel(
      id: int.parse(json['id'].toString()),
      shortCode: json['short_code'] ?? '',
      nameEn: json['name_en'] ?? '',
      nameMn: json['name_mn'] ?? '',
      isPrivate: int.parse(json['isPrivate'].toString()),
      lastIndex: int.parse(json['last_index'].toString()), // <-- Parse last_index
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'short_code': shortCode,
      'name_en': nameEn,
      'name_mn': nameMn,
      'isPrivate': isPrivate,
      'last_index': lastIndex, // <-- Add to toJson
    };
  }
}