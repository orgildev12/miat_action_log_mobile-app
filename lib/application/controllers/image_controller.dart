import 'dart:io';
import 'package:action_log_app/core/network/api_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class HazardImageController {
  final ApiClient _apiClient;

  // State notifiers
  final ValueNotifier<bool> isUploading = ValueNotifier(false);
  final ValueNotifier<String?> errorMessage = ValueNotifier(null);
  final ValueNotifier<int> uploadedCount = ValueNotifier(0);

  HazardImageController({required ApiClient apiClient})
      : _apiClient = apiClient;

  /// Upload up to 3 images for a given hazard
  Future<void> uploadImages({
    required int hazardId,
    required List<File> images,
    required String token,
  }) async {
    if (images.isEmpty) {
      errorMessage.value = 'No images selected';
      return;
    }

    if (images.length > 3) {
      errorMessage.value = 'You can upload up to 3 images only';
      return;
    }

    isUploading.value = true;
    errorMessage.value = null;

    try {
      // final headers = {'Authorization': 'Bearer $token'};
      final result = await _apiClient.postMultipart(
        '/hazard/$hazardId/images',
        files: images,
        // headers: headers,
      );

      uploadedCount.value = images.length;
      showUploadSuccessSnackBar();
      print('Uploaded images result: $result');
    } catch (e) {
      errorMessage.value = e.toString();
      print('Image upload failed: $e');
    } finally {
      isUploading.value = false;
    }
  }

  void showUploadSuccessSnackBar() {
    Get.showSnackbar(
      GetSnackBar(
        messageText: Text(
          'amjilttai upload hiigdle bro',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
        icon:  Icon(IconsaxPlusLinear.cloud, color: success),
        snackStyle: SnackStyle.FLOATING,
        borderRadius: 16,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        duration: const Duration(seconds: 2),
        animationDuration: const Duration(milliseconds: 400),
        isDismissible: true,
        snackPosition: SnackPosition.TOP,
      ),
    );
  }
}
