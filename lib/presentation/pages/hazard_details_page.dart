import 'package:action_log_app/application/controllers/hazard_controller.dart';
import 'package:action_log_app/core/di/features/user_di.dart';
import 'package:action_log_app/domain/entities/hazard.dart';
import 'package:action_log_app/domain/entities/user.dart';
import 'package:action_log_app/presentation/components/hazard_image.dart';
import 'package:action_log_app/presentation/components/info_panel.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:action_log_app/presentation/components/hazart_details_item.dart';
import 'package:intl/intl.dart';
import 'package:action_log_app/l10n/app_localizations.dart';

class HazardDetailsPage extends StatefulWidget {
  final Hazard hazard;
  const HazardDetailsPage({
    super.key,
    required this.hazard,
    });

  @override
  State<HazardDetailsPage> createState() => _HazardDetailsPageState();
}

class _HazardDetailsPageState extends State<HazardDetailsPage> {
  final controller = Get.put(HazardController());
  User user = User();
  String email = '';
  @override
  void initState(){
    super.initState();
    controller.fetchHazardImages(widget.hazard);
    if(widget.hazard.statusMn != 'Илгээгдсэн'){
      fetchUserEmail();
      print(email);
    }
  }

  void fetchUserEmail() async {
    user = await UserDI.fetchUserInfoUseCase.call();
    if (mounted) {
      setState(() {
        print('the email is ${user.email}');
        email = user.email ?? '';
        print(email);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(IconsaxPlusLinear.arrow_left_1, color: black),
          onPressed: () {
            Navigator.of(context).pop();
            controller.clearImages();
          }
        ),
        title: Text(
          AppLocalizations.of(context)!.hazardDetails,
          style: TextStyle(
            color: black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HazartDetailsItem(text1: AppLocalizations.of(context)!.hazardCode, text2: widget.hazard.code),
              SizedBox(height: 8),
              HazartDetailsItem(
                text1: AppLocalizations.of(context)!.sentDate,
                text2: DateFormat('yyyy.MM.dd').format(widget.hazard.dateCreated),
              ),
              SizedBox(height: 8),
              HazartDetailsItem(
                text1: AppLocalizations.of(context)!.status, 
                text2: Localizations.localeOf(context).languageCode == 'mn' ? widget.hazard.statusMn : widget.hazard.statusEn
              ),
              SizedBox(height: 24),
              InfoPanel(
                hazardStatusMn: widget.hazard.statusMn,
                hazardCode: widget.hazard.code,
                email: email,
                ),
              SizedBox(height: 56),
              Text(AppLocalizations.of(context)!.content, style: TextStyle(fontSize:20, fontWeight: FontWeight.w600, color: black)),
              SizedBox(height: 12),
              Text(widget.hazard.description, style: TextStyle(fontSize:14,  color: black)),
              SizedBox(height: 8),
              Text(AppLocalizations.of(context)!.solution, style: TextStyle(fontSize:16,  color: black, fontWeight: FontWeight.w500)),
              Text(widget.hazard.solution, style: TextStyle(fontSize:14,  color: black)),
              SizedBox(height: 32),
              Obx(() {
                if (controller.hazardImages.isEmpty) return const SizedBox.shrink();
                  return Column(
                    children: controller.hazardImages
                        .asMap()
                        .entries
                        .map((entry) {
                          final index = entry.key;
                          final file = entry.value;
                          return HazardImage(
                            imageFile: file,
                            hasDeleteAction: false,
                            onLongPress: (){},
                            onPress: () {
                              controller.openGallery(context, index);
                            },
                          );
                        })
                        .toList(),
                  );
              }),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}