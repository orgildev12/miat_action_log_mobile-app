import 'dart:io';
import 'package:action_log_app/application/use_cases/location_use_cases/clear_location_cache.dart';
import 'package:action_log_app/application/use_cases/location_use_cases/fetch_locations_use_case.dart';
import 'package:action_log_app/core/di/features/hazard_di.dart';
import 'package:action_log_app/core/di/features/location_di.dart';
import 'package:action_log_app/core/di/features/user_di.dart';
import 'package:action_log_app/core/error/exceptions.dart';
import 'package:action_log_app/domain/entities/location.dart';
import 'package:action_log_app/domain/entities/user.dart';
import 'package:action_log_app/l10n/app_localizations.dart';
import 'package:action_log_app/models/post_hazard_model.dart';
import 'package:action_log_app/presentation/components/pop_up.dart';
import 'package:action_log_app/presentation/pages/main_navigator.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class PostHazardController extends GetxController {
  // Reactive state
  var isUploading = false.obs;
  var errorMessage = RxnString();
  var uploadedCount = 0.obs;

  var locations = <Location>[].obs;
  var firstLocationFormValue = ''.obs;
  var secondLocationFormValue = ''.obs;
  var selectedLocationGroupName = ''.obs;
  var selectedLocationGroupId = Rxn<int>();
  var locationId = Rxn<int>();
  var isSelectedLocationGroup = false.obs;

  var description = ''.obs;
  var solution = ''.obs;

  String? languageCode = 'mn';

  final formKey = GlobalKey<FormState>();
  User user = User();

  FetchLocationsUseCase fetchLocationUseCase = LocationDI.fetchLocationsUseCase;
  ClearLocationCacheUseCase clearLocationCacheUseCase = LocationDI.clearLocationCacheUseCase;

  late String username;
  late String email;
  late String phoneNumber;

  bool get isActive =>
      locationId.value != null &&
      description.value.trim().isNotEmpty &&
      solution.value.trim().isNotEmpty;

  // ------------------------------
  // Image Upload
  Future<void> uploadImages({
    required int hazardId,
    required List<File> images,
    required bool isUserLoggedIn,
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
      await HazardDI.postHazardUseCase.uploadHazardImages(hazardId, images, isUserLoggedIn: isUserLoggedIn);
      uploadedCount.value = images.length;
      showUploadSuccessSnackBar();
      // print('Uploaded images result: $result');
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
        messageText: const Text(
          'Upload successful!',
          style: TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w500),
        ),
        backgroundColor: white,
        icon: const Icon(IconsaxPlusLinear.cloud, color: Colors.green),
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

  // ------------------------------
  // Load user
  Future<void> loadUserInfo(context) async {
    try {
      final fetchedUser = await UserDI.fetchUserInfoUseCase.call();
      user = fetchedUser;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to load user info: $e')));
    }
  }

  // ------------------------------
  // Fetch locations
  Future<void> fetchLocations(BuildContext context) async {
    try {
      await clearLocationCacheUseCase.call();
      final result = await fetchLocationUseCase.call(includeLocationsWithLGroup: true);
      locations.value = result;
    } on ServerException catch (e) {
      _openErrorDialog(context, statusCode: e.statusCode);
    } catch (e) {
      _openErrorDialog(context);
    }
  }

  // ------------------------------
  // Location selection
  void setFirstLocationFormValue(Location selectedLocation) {
    if (selectedLocation.locationGroupId == null) {
      isSelectedLocationGroup.value = false;
      firstLocationFormValue.value = languageCode == 'mn'
          ? selectedLocation.nameMn
          : selectedLocation.nameEn;
      secondLocationFormValue.value = '';
      selectedLocationGroupId.value = null;
      locationId.value = selectedLocation.id;
      selectedLocationGroupName.value = '';
    } else {
      isSelectedLocationGroup.value = true;
      selectedLocationGroupId.value = selectedLocation.locationGroupId;
      firstLocationFormValue.value = languageCode == 'mn'
          ? selectedLocation.groupNameMn!
          : selectedLocation.groupNameEn!;
      secondLocationFormValue.value = '';
      selectedLocationGroupName.value = firstLocationFormValue.value;
      locationId.value = null;
    }
  }

  void setSecondLocationFormValue(Location selectedLocation) {
    secondLocationFormValue.value = languageCode == 'mn'
        ? selectedLocation.nameMn
        : selectedLocation.nameEn;
    locationId.value = selectedLocation.id;
  }

  // ------------------------------
  // Submit hazard
  Future<void> submitHazard(int hazardTypeId, context) async {
    if (formKey.currentState!.validate()) {
      try {
        final hazardModel = PostHazardModel(
          userId: user.id,
          userName: user.username,
          email: user.email,
          phoneNumber: user.phoneNumber,
          typeId: hazardTypeId,
          locationId: locationId.value!,
          description: description.value,
          solution: solution.value,
        );

        final result = await HazardDI.postHazardUseCase
            .call(hazardModel, isUserLoggedIn: user.id != null);

        if (result == true) {
          _openSuccessDialog(context, AppLocalizations.of(context)!.sentSuccessfully);
        }
      } on ServerException catch (e) {
        _openErrorDialog(context, statusCode: e.statusCode);
      } catch (e) {
        _openErrorDialog(context);
      }
    }
  }

  // ------------------------------
  // Dialogs
  Future<void> _openErrorDialog(
    BuildContext context, {
    int? statusCode,
    String? dialogTitle,
    String? dialogDescription,
  }) async {
    String? title = dialogTitle;
    String? description = dialogDescription;

    if (statusCode != null) {
      switch (statusCode) {
        case 401:
          title = AppLocalizations.of(context)!.warning;
          description = AppLocalizations.of(context)!.description500;
          break;
        case 503:
          title = AppLocalizations.of(context)!.weAreSorry;
          description = AppLocalizations.of(context)!.description503;
          break;
        default:
          title = AppLocalizations.of(context)!.sorry;
          description = AppLocalizations.of(context)!.description500;
      }
    }

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopUp(
          icon: IconsaxPlusLinear.close_circle,
          colorTheme: 'danger',
          title: title ?? AppLocalizations.of(context)!.sorry,
          content: description ?? AppLocalizations.of(context)!.description500,
          onPress: () => Navigator.pop(context),
        );
      },
    );
  }

  void _openSuccessDialog(BuildContext context, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopUp(
          icon: IconsaxPlusLinear.tick_circle,
          colorTheme: 'success',
          title: AppLocalizations.of(context)!.success,
          content: description,
          onPress: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainNavigator()),
              (route) => false,
            );
          },
        );
      },
    );
  }
}
