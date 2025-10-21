import 'package:action_log_app/application/controllers/post_hazard_controller.dart';
import 'package:action_log_app/application/use_cases/hazard_use_cases/post_hazard_use_case.dart';
import 'package:action_log_app/application/use_cases/user_use_cases/fetch_user_info_use_case.dart';
import 'package:action_log_app/domain/entities/location.dart';
import 'package:action_log_app/l10n/app_localizations.dart';
import 'package:action_log_app/presentation/components/add_image_button.dart';
import 'package:action_log_app/presentation/components/big_button.dart';
import 'package:action_log_app/presentation/components/hazard_drop_down_form.dart';
import 'package:action_log_app/presentation/components/hazard_form_item.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class PostHazardPage extends StatelessWidget {
  final PostHazardUseCase postHazardUseCase;
  final FetchUserInfoUseCase fetchUserInfoUseCase;
  final int hazardTypeId;
  final String hazardTypeName;

  const PostHazardPage({
    super.key,
    required this.postHazardUseCase,
    required this.fetchUserInfoUseCase,
    required this.hazardTypeId,
    required this.hazardTypeName,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PostHazardController());
    controller.languageCode = Get.locale?.languageCode ?? 'mn';
    controller.loadUserInfo(context);
    controller.fetchLocations(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(IconsaxPlusLinear.arrow_left_1, color: black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          AppLocalizations.of(context)!.reportHazard,
          style: const TextStyle(color: black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Text(
              hazardTypeName,
              style: TextStyle(color: primaryColor, fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.weWillUseThisForOnly,
              style: const TextStyle(color: black, fontSize: 14),
            ),
            const SizedBox(height: 32),

            Form(
              key: controller.formKey,
              child: Obx(() => Column(
                children: [
                  // First location dropdown
                  HazardDropDownForm(
                    hintText: AppLocalizations.of(context)!.selectLocation,
                    labelText: AppLocalizations.of(context)!.location,
                    formValue: controller.firstLocationFormValue.value,
                    dropDownItems: [
                      ...controller.locations
                          .where((location) => location.locationGroupId == null)
                          .map((location) => {
                                'label': controller.languageCode == 'mn'
                                    ? location.nameMn
                                    : location.nameEn,
                                'isGroup': false,
                              }),
                      ...controller.locations
                          .where((location) => location.locationGroupId != null)
                          .map((location) => controller.languageCode == 'mn'
                              ? location.groupNameMn ?? ''
                              : location.groupNameEn ?? '')
                          .toSet()
                          .map((groupName) => {'label': groupName, 'isGroup': true}),
                    ],
                    onValueChanged: (val) {
                      final selectedLocation = controller.locations.firstWhere(
                        (location) =>
                            (controller.languageCode == 'mn'
                                ? location.nameMn == val || location.groupNameMn == val
                                : location.nameEn == val || location.groupNameEn == val),
                        orElse: () => Location(id: -1, nameMn: val, nameEn: val),
                      );
                      if (selectedLocation.id != -1) {
                        controller.setFirstLocationFormValue(selectedLocation);
                      }
                    },
                  ),

                  // Second dropdown if group selected
                  if (controller.isSelectedLocationGroup.value)
                    Column(
                      children: [
                        const SizedBox(height: 8),
                        HazardDropDownForm(
                          hintText: controller.languageCode == 'mn'
                              ? '${controller.selectedLocationGroupName.value} сонгох'
                              : 'Select ${controller.selectedLocationGroupName.value}',
                          formValue: controller.locationId.value != null
                              ? (controller.languageCode == 'mn'
                                  ? controller.locations.firstWhere((location) => location.id == controller.locationId.value).nameMn
                                  : controller.locations.firstWhere((location) => location.id == controller.locationId.value).nameEn)
                              : '',
                          dropDownItems: controller.locations
                              .where((location) =>
                                  location.locationGroupId == controller.selectedLocationGroupId.value)
                              .map((location) => {
                                    'label': controller.languageCode == 'mn'
                                        ? location.nameMn
                                        : location.nameEn,
                                    'isGroup': false,
                                  })
                              .toList(),
                          onValueChanged: (val) {
                            final selectedLocation = controller.locations.firstWhere(
                              (location) =>
                                  location.locationGroupId == controller.selectedLocationGroupId.value &&
                                  (controller.languageCode == 'mn'
                                      ? location.nameMn == val
                                      : location.nameEn == val),
                              orElse: () => Location(id: -1, nameMn: val, nameEn: val),
                            );
                            if (selectedLocation.id != -1) {
                              controller.setSecondLocationFormValue(selectedLocation);
                            }
                          },
                        ),
                      ],
                    ),

                  const SizedBox(height: 28),

                  // Hazard details
                  HazardFormItem(
                    labelText: AppLocalizations.of(context)!.hazardDetails,
                    hintText: AppLocalizations.of(context)!.hazardDescription,
                    formValue: controller.description.value,
                    onValueChanged: (val) => controller.description.value = val,
                    validator: (val) {
                      if (val == null || val.trim().length < 10) {
                        return AppLocalizations.of(context)!.tooShort;
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 28),

                  // Suggestion
                  HazardFormItem(
                    labelText: AppLocalizations.of(context)!.suggession,
                    hintText: AppLocalizations.of(context)!.suggessionLong,
                    formValue: controller.solution.value,
                    onValueChanged: (val) => controller.solution.value = val,
                    validator: (val) {
                      if (val == null || val.trim().length < 10) {
                        return AppLocalizations.of(context)!.tooShort;
                      }
                      return null;
                    },
                  ),
                ],
              )),
            ),

            const SizedBox(height: 28),
            Text(
              AppLocalizations.of(context)!.image,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: black),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: AddImageButton(
                    buttonText: AppLocalizations.of(context)!.takePicture,
                    iconData: IconsaxPlusLinear.camera,
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  flex: 1,
                  child: AddImageButton(
                    buttonText: AppLocalizations.of(context)!.attachzPicture,
                    iconData: IconsaxPlusLinear.paperclip_2,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 64),
            Obx(() => BigButton(
                  buttonText: AppLocalizations.of(context)!.send,
                  isActive: controller.isActive,
                  onTap: () => controller.submitHazard(hazardTypeId, context),
                  iconData: IconsaxPlusLinear.send_2,
                )),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
