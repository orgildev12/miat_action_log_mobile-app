class PostHazardModel {
  final int? userId;
  final String? userName;
  final String? email;
  final String? phoneNumber;
  final int typeId;
  final int locationId;
  final String description;
  final String solution;

  PostHazardModel({
    this.userId,
    this.userName,
    this.email,
    this.phoneNumber,
    required this.typeId,
    required this.locationId,
    required this.description,
    required this.solution,
  });

  @override
  String toString() {
    return 'PostHazardModel(userId: $userId, userName: $userName, email: $email, phoneNumber: $phoneNumber, typeId: $typeId, locationId: $locationId, description: $description, solution: $solution)';
  }
  
  Map<String, Object?> toJson(bool isUserLoggedIn) {

    if (isUserLoggedIn != false) {
      return {
        'user_id': userId,
        'type_id': typeId,
        'location_id': locationId,
        'description': description,
        'solution': solution,
      };
    }

    return {
      'user_name': userName,
      'email': email,
      'phone_number': phoneNumber,
      'type_id': typeId,
      'location_id': locationId,
      'description': description,
      'solution': solution,
    };
  }
}