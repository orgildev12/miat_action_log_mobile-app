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
  final Date dateCreated;

  HazardModel({
    required.id;
    required.code;
    required.statusEn;
    required.statusMn;
    required.userId;
    required.typeId;
    required.locationId;
    required.description;
    required.solution;
    required.isPrivate;
    required.dateCreated;
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
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
      dateCreated: json['date_created'],
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
      'solution' : solution,
      'isPrivate' : isPrivate,
      'dateCreated' : dateCreated
    }
  }
}