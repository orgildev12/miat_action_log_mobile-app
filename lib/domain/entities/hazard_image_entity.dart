import 'dart:io';

class HazardImageEntity {
  final int id;
  final int hazardId;
  final File imageData;

  HazardImageEntity({
    required this.id,
    required this.hazardId,
    required this.imageData,
  });
}