import 'dart:io';
import 'package:action_log_app/application/controllers/image_controller.dart';
import 'package:action_log_app/core/network/api_client.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:action_log_app/presentation/styles/colors.dart';

class HazardImageUploadPage extends StatefulWidget {
  final int hazardId;
  final String userToken;
  final ApiClient apiClient;

  const HazardImageUploadPage({
    super.key,
    required this.hazardId,
    required this.userToken,
    required this.apiClient,
  });

  @override
  State<HazardImageUploadPage> createState() => _HazardImageUploadPageState();
}

class _HazardImageUploadPageState extends State<HazardImageUploadPage> {
  final ImagePicker _picker = ImagePicker();
  late final HazardImageController _controller;
  List<File> _selectedImages = [];

  @override
  void initState() {
    super.initState();
    _controller = HazardImageController(apiClient: widget.apiClient);
  }

  // Future<void> _pickImages() async {
  //   try {
  //     final pickedFiles = await _picker.pickMultiImage(
  //       imageQuality: 80,
  //       maxWidth: 1200,
  //       maxHeight: 1200,
  //     );

  //     if (pickedFiles.isEmpty) return; // Only check empty

  //     final files = pickedFiles.map((x) => File(x.path)).toList();

  //     setState(() {
  //       _selectedImages = files.length > 3 ? files.sublist(0, 3) : files;
  //     });
  //   } catch (e) {
  //     print(e);
  //     Get.snackbar(
  //       'Error', 'Failed to pick images: $e',
  //       duration: Duration(days: 1)
  //       );
  //   }
  // }

List<XFile> selectedImages = [];

Future<void> pickImage2({
  ImageSource source = ImageSource.gallery,
  int imageQuality = 100,
  bool multiple = false,
}) async {
  List<XFile> newImages = [];

  if (multiple) {
    newImages = await _picker.pickMultiImage(imageQuality: imageQuality);
  } else {
    final file = await _picker.pickImage(
      source: source,
      imageQuality: imageQuality,
    );
    if (file != null) newImages = [file];
  }

  if (newImages.isNotEmpty) {
    // Convert XFile -> File and update _selectedImages
    setState(() {
      _selectedImages = newImages
          .map((x) => File(x.path))
          .toList()
          .length > 3
          ? newImages.map((x) => File(x.path)).toList().sublist(0, 3)
          : newImages.map((x) => File(x.path)).toList();
    });
  }
}



  // Future<Cropped>

  Future<void> _uploadImages() async {
    if (_selectedImages.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select at least one image',
        duration: const Duration(days: 1), // lasts 24 hours
        snackPosition: SnackPosition.BOTTOM, // optional
        isDismissible: true, // user can swipe to dismiss
      );
      return;
    }

    await _controller.uploadImages(
      hazardId: widget.hazardId,
      images: _selectedImages,
      token: widget.userToken,
    );

    if (_controller.errorMessage.value != null) {
      Get.snackbar('Error', _controller.errorMessage.value!);
    } else {
      setState(() {
        _selectedImages = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Hazard Images', style: TextStyle(color: black),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: () => pickImage2(multiple: true),
              icon: const Icon(Icons.photo_library),
              label: const Text('Pick Images'),
            ),

            const SizedBox(height: 16),
            _selectedImages.isEmpty
                ? const Text('No images selected')
                : SizedBox(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _selectedImages.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        return Image.file(_selectedImages[index], width: 100, height: 100, fit: BoxFit.cover);
                      },
                    ),
                  ),
            const SizedBox(height: 24),
            ValueListenableBuilder<bool>(
              valueListenable: _controller.isUploading,
              builder: (_, isUploading, __) {
                return ElevatedButton.icon(
                  onPressed: isUploading ? null : _uploadImages,
                  icon: isUploading ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2) : const Icon(Icons.upload_file),
                  label: Text(isUploading ? 'Uploading...' : 'Upload Images'),
                );
              },
            ),
            const SizedBox(height: 16),
            ValueListenableBuilder<int>(
              valueListenable: _controller.uploadedCount,
              builder: (_, count, __) {
                return count > 0 ? Text('$count image(s) uploaded successfully!', style: const TextStyle(color: success)) : const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
