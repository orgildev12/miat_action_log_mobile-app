class HazardModel {
  final int id;
  final String code;
  final int? userId;
  final String? userName;
  final String? email;
  final String? phoneNumber;
  final int typeId;
  final int locationId;
  final String description;
  final String solution;
  final int isPrivate;
  final DateTime dateCreated;

  HazardModel({
    required this.id,
    required this.code,
    this.userId,
    this.userName,
    this.email,
    this.phoneNumber,
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
      code: json['code'] ?? '',
      userId: json['user_id'],
      userName: json['user_name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      typeId: json['type_id'],
      locationId: json['location_id'],
      description: json['description'] ?? '',
      solution: json['solution'] ?? '',
      isPrivate: json['is_private'] ?? 0,
      dateCreated: json['date_created'] != null 
          ? DateTime.parse(json['date_created'].toString())
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'user_id': userId,
      'user_name': userName,
      'email': email,
      'phone_number': phoneNumber,
      'type_id': typeId,
      'location_id': locationId,
      'description': description,
      'solution': solution,
      'is_private': isPrivate,
      'date_created': dateCreated.toIso8601String(),
    };
  }
}