class HazardModel {
  final int id;
  final String code;
  final String statusEn;
  final String statusMn;
  final int? userId;
  final int typeId;
  final int locationId;
  final String description;
  final String solution;
  final int isPrivate;
  final DateTime dateCreated;

  HazardModel({
    required this.id,
    required this.code,
    required this.statusEn,
    required this.statusMn,
    this.userId,
    required this.typeId,
    required this.locationId,
    required this.description,
    required this.solution,
    required this.isPrivate,
    required this.dateCreated,
  });

  factory HazardModel.fromJson(Map<String, dynamic> json) {
    return HazardModel(
      id: json['id'],
      code: json['code'],
      statusEn: json['status_en'],
      statusMn: json['status_mn'],
      userId: json['user_id'],
      typeId: json['type_id'],
      locationId: json['location_id'],
      description: json['description'],
      solution: json['solution'],
      isPrivate: json['is_private'],
      dateCreated: DateTime.parse(json['date_created']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'status_en': statusEn,
      'status_mn': statusMn,
      'user_id': userId,
      'type_id': typeId,
      'location_id': locationId,
      'description': description,
      'solution': solution,
      'is_private': isPrivate,
      'date_created': dateCreated.toIso8601String(),
    };
  }
}