import 'package:action_log_app/core/di/features/user_di.dart';
import 'package:action_log_app/core/network/api_client.dart';
import 'package:action_log_app/l10n/app_localizations.dart';
import 'package:action_log_app/presentation/components/pop_up.dart';
import 'package:action_log_app/presentation/components/settings_page_item.dart';
import 'package:action_log_app/presentation/pages/main_navigator.dart';
import 'package:action_log_app/presentation/pages/upload_image_temp_page.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class SettingsPage extends StatelessWidget {
  final VoidCallback onLogout; // Add a callback for logout
  const SettingsPage({super.key, required this.onLogout});


  @override
  Widget build(BuildContext context) {
    final authController = UserDI.controller;
    final isUserLoggedIn = authController.isLoggedIn.value;
    void _logout () {
      authController.logout();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MainNavigator(),
        ),
        (route) => false,
      );
      onLogout();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:  16.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.menu, style: TextStyle(fontSize:24, fontWeight: FontWeight.w600, color: black)),
          SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                SettingsPageItem(title: 'upload image temp page', icon: IconsaxPlusBold.quote_down, onTap: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => HazardImageUploadPage(
                        apiClient: ApiClient(baseUrl: 'http://10.0.2.2:3000/api'),
                        userToken: 'asdfasdlfkj ljasdf',
                        hazardId: 281,
                      ),
                    ),
                  );
                }),
                SettingsPageItem(title: 'Энд өөр зүйлс нэмж болно', icon: IconsaxPlusBold.heart, onTap: (){}),
                SettingsPageItem(title: 'Энд өөр зүйлс нэмж болно', icon: IconsaxPlusBold.sms_notification, onTap: (){}),
              ],
            ),
          ),
          SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                SettingsPageItem(title: 'Энд өөр зүйлс нэмж болно', icon: IconsaxPlusBold.user, onTap: (){}),
                SettingsPageItem(title: 'Энд өөр зүйлс нэмж болно', icon: IconsaxPlusBold.setting_2, onTap: (){}),
              ],
            ),
          ),
          SizedBox(height: 24),
          isUserLoggedIn ?
          Container(
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                SettingsPageItem(
                  title: AppLocalizations.of(context)!.logout,
                  icon: IconsaxPlusBroken.logout,
                  isRed: true,
                  hasNoTrailingIcon: true,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return PopUp(
                          icon: IconsaxPlusLinear.logout,
                          colorTheme: 'danger',
                          title: AppLocalizations.of(context)!.areYouSureYouLogout,
                          // content: 'Үргэлжлүүлэхийн тулд нэвтрэх шаардлагатай.',
                          hasTwoButtons: true,
                          onPress: () => _logout(),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ) : SizedBox.shrink(),
        ],
      ),
    );
  }
}