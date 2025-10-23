import 'dart:io';
import 'package:action_log_app/domain/entities/hazard_image_entity.dart';
import 'package:action_log_app/models/hazard_image_model.dart';

extension HazardImageMapper on HazardImageModel {
  HazardImageEntity toEntity() {
    final file = File(imageData);

    return HazardImageEntity(
      id: id,
      hazardId: hazardId,
      imageData: file,
    );
  }
}
