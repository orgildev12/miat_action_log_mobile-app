import 'package:action_log_app/l10n/app_localizations.dart';
import 'package:action_log_app/presentation/components/small_login_button.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class SecretHazardPageForTempUser extends StatelessWidget {
  const SecretHazardPageForTempUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(IconsaxPlusLinear.arrow_left_1, color: black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Мэдээлэл өгөх',
          style: TextStyle(
            color: black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                          SizedBox(height: 32),
              Text(AppLocalizations.of(context)!.confidentialHazardReport,
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.ifYouHideYourIdentity,
                style: TextStyle(
                  color: black,
                  fontSize: 14,
                )
              ),
              SizedBox(height: 32),

              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                            color: backgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: primaryColor
                  )

                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Text(
                        AppLocalizations.of(context)!.attention,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: black
                        ),
                      ),
                      SizedBox(height: 4),
                    Text(
                      AppLocalizations.of(context)!.thisReportCanOnly,
                      style: TextStyle(
                        fontSize: 14,
                        color: black
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SmallLoginButton(),
                ],
              )
          ],
          ),
        
        )
    );
  }
}