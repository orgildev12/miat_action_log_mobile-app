class Hazard {
  final int id;
  final String? code;
  final String? statusEn;
  final String? statusMn;
  final int? userId;
  final int typeId
  final String typeNameEn;
  final String typeNameMn;
  final int locationId;
  final String locationNameEn;
  final String locationNameMn;
  final String description;
  final String solution;
  final int isPrivate;
  final Date? dateCreated;
  final Map<String, <Response>>? responseOfHazard;

  Hazard({
    required.id;
    required.code;
    required.statusEn;
    required.statusMn;
    required.typeNameEn;
    required.typeNameMn;
    required.locationName;
    required.locationName;
    required.description;
    required.solution;
    required.isPrivate;
    required.dateCreated;
    required.responseOfHazard
  });
}