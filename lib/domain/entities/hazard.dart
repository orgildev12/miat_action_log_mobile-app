import 'package:action_log_app/domain/entities/response.dart';

class Hazard {
  final int id;
  final String? code;
  final int? userId;
  final String? userName;
  final String? email;
  final String? phoneNumber;
  final int typeId;
  final String typeNameEn;
  final String typeNameMn;
  final int locationId;
  final String locationNameEn;
  final String locationNameMn;
  final String description;
  final String solution;
  final int isPrivate;
  final DateTime? dateCreated;
  final Response? responseOfHazard;

  Hazard({
    required this.id,
    required this.code,
    required this.userId,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.typeId,
    required this.typeNameEn,
    required this.typeNameMn,
    required this.locationId,
    required this.locationNameEn,
    required this.locationNameMn,
    required this.description,
    required this.solution,
    required this.isPrivate,
    required this.dateCreated,
    required this.responseOfHazard,
  });
}