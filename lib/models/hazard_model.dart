class HazardModel {
  final int id;
  final String code;
  final String statusEn;
  final String statusMn;
  final int? userId;
  final String? userName;
  final String? email;
  final String? phoneNumber;
  final int typeId;
  final int locationId;
  final String description;
  final String solution;
  final DateTime dateCreated;
  final String typeNameEn;
  final String typeNameMn;
  final String locationNameEn;
  final String locationNameMn;
  final int isResponseConfirmed;
  final String? responseBody;
  final int isPrivate;
  final DateTime? dateUpdated;

  HazardModel({
    required this.id,
    required this.code,
    required this.statusEn,
    required this.statusMn,
    this.userId,
    this.userName,
    this.email,
    this.phoneNumber,
    required this.typeId,
    required this.locationId,
    required this.description,
    required this.solution,
    required this.dateCreated,
    required this.typeNameEn,
    required this.typeNameMn,
    required this.locationNameEn,
    required this.locationNameMn,
    required this.isResponseConfirmed,
    this.responseBody,
    required this.isPrivate,
    this.dateUpdated,
  });

  factory HazardModel.fromJson(Map<String, dynamic> json) {
  return HazardModel(
    id: json['id'],
    code: json['code'],
    statusEn: json['statusEn'],
    statusMn: json['statusMn'],
    userId: json['user_id'],
    userName: json['user_name'],
    email: json['email'],
    phoneNumber: json['phone_number'],
    typeId: json['type_id'],
    locationId: json['location_id'],
    description: json['description'] ?? '',
    solution: json['solution'] ?? '',
    dateCreated: json['date_created'] != null
      ? DateTime.parse(json['date_created'].toString())
      : DateTime.now(),
    typeNameEn: json['type_name_en'],
    typeNameMn: json['type_name_mn'],
    locationNameEn: json['location_name_en'],
    locationNameMn: json['location_name_mn'],
    isResponseConfirmed: json['is_response_confirmed'],
    responseBody: json['response_body'],
    isPrivate: json['is_private'],
    dateUpdated: json['date_updated'] != null
      ? DateTime.parse(json['date_updated'].toString())
      : null,
  );
  }

// Татсан hazard-аа cache хийхэд хэрэглэнэ.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'statusEn': statusEn,
      'statusMn': statusMn,
      'user_id': userId,
      'user_name': userName,
      'email': email,
      'phone_number': phoneNumber,
      'type_id': typeId,
      'location_id': locationId,
      'description': description,
      'solution': solution,
      'date_created': dateCreated.toIso8601String(),
      'type_name_en': typeNameEn,
      'type_name_mn': typeNameMn,
      'location_name_en': locationNameEn,
      'location_name_mn': locationNameMn,
      'is_response_confirmed': isResponseConfirmed,
      'response_body': responseBody,
      'is_private': isPrivate,
      'date_updated': dateUpdated?.toIso8601String(),
    };
  }
}