class Hazard {
  final int id;
  final String code;
  final String statusEn;
  final String statusMn;
  final String typeNameEn;
  final String typeNameMn;
  final String locationNameEn;
  final String locationNameMn;
  final String description;
  final String solution;
  final DateTime dateCreated;
  final int isResponseConfirmed;
  final String? responseBody;
  final int isPrivate;
  final DateTime? dateUpdated;
  final int hasImage;

  Hazard({
  required this.id,
  required this.code,
  required this.statusEn,
  required this.statusMn,
  required this.typeNameEn,
  required this.typeNameMn,
  required this.locationNameEn,
  required this.locationNameMn,
  required this.description,
  required this.solution,
  required this.dateCreated,
  required this.isResponseConfirmed,
  this.responseBody,
  required this.isPrivate,
  this.dateUpdated,
  required this.hasImage
  });
}