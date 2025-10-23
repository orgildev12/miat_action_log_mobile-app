import 'dart:io';

import 'package:action_log_app/application/use_cases/hazard_use_cases/fetch_hazard_image_use_case.dart';
import 'package:action_log_app/core/di/features/hazard_di.dart';
import 'package:get/get.dart';

class HazardController {
  var hazardImages = <File>[].obs;

  FetchHazardImageUseCase fetchHazardImageUseCase = HazardDI.fetchHazardImageUseCase;

  void fetchHazardImages(int hazardId) async {
    try {
      final result = await fetchHazardImageUseCase.call(hazardId: hazardId);

      hazardImages.value = result.map((e) => e.imageData).toList();
    } catch (e) {
      print('Failed to fetch hazard images: $e');
    }
  }


}