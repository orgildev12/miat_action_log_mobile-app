import 'dart:io';

import 'package:action_log_app/application/use_cases/hazard_use_cases/fetch_hazard_image_use_case.dart';
import 'package:action_log_app/core/di/features/hazard_di.dart';
import 'package:action_log_app/domain/entities/hazard.dart';
import 'package:action_log_app/presentation/pages/full_screen_gallary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HazardController {
  var hazardImages = <File>[].obs;

  FetchHazardImageUseCase fetchHazardImageUseCase = HazardDI.fetchHazardImageUseCase;

  void fetchHazardImages(Hazard hazard) async {
    try {
      if(hazard.hasImage == 0){
        return;
      }
      final result = await fetchHazardImageUseCase.call(hazardId: hazard.id);

      hazardImages.value = result.map((e) => e.imageData).toList();
    } catch (e) {
      print('Failed to fetch hazard images: $e');
    }
  }

  void clearImages(){
    hazardImages = <File>[].obs;
  }

  void openGallery(BuildContext context, int initialIndex) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Gallery",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.3), // soft background fade
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, anim1, anim2) {
        return  FullScreenGallery(
          images: hazardImages,
          initialIndex: initialIndex,
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: anim1, curve: Curves.easeOut),
          child: child,
        );
      },
    );
  }
}