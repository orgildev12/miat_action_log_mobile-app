import 'package:action_log_app/domain/entities/hazard.dart';
// import 'package:action_log_app/presentation/components/hazard_image.dart';
import 'package:action_log_app/presentation/components/info_panel.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final currentLanguage = Localizations.localeOf(context).languageCode;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(IconsaxPlusLinear.arrow_left_1, color: black),
          onPressed: () => Navigator.of(context).pop(),
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
              InfoPanel(content: AppLocalizations.of(context)!.yourRequestWasSent),
              SizedBox(height: 56),
              Text(AppLocalizations.of(context)!.content, style: TextStyle(fontSize:20, fontWeight: FontWeight.w600, color: black)),
              SizedBox(height: 12),
              Text(widget.hazard.description, style: TextStyle(fontSize:14,  color: black)),
              SizedBox(height: 8),
              Text(AppLocalizations.of(context)!.solution, style: TextStyle(fontSize:16,  color: black, fontWeight: FontWeight.w500)),
              Text(widget.hazard.solution, style: TextStyle(fontSize:14,  color: black)),
              SizedBox(height: 32),
              // HazardImage()
            ],
          ),
        ),
      ),
    );
  }
}