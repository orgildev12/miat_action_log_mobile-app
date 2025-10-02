import 'package:action_log_app/core/di/features/user_di.dart';
import 'package:action_log_app/main.dart';
import 'package:action_log_app/presentation/components/settings_page_item.dart';
import 'package:action_log_app/presentation/pages/main_navigator.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class SettingsPage extends StatelessWidget {
  final VoidCallback onLogout; // Add a callback for logout
  const SettingsPage({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    final logoutUseCase = UserDI.logoutUseCase;
    final isUserLoggedIn = isLoggedInNotifier.value;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:  16.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Цэс', style: TextStyle(fontSize:24, fontWeight: FontWeight.w600, color: black)),
          SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                SettingsPageItem(title: 'Энд өөр зүйлс нэмж болно', icon: IconsaxPlusBold.quote_down, onTap: (){}),
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
                  title: 'Гарах',
                  icon: IconsaxPlusBroken.logout,
                  isRed: true,
                  hasNoTrailingIcon: true,
                  onTap: () {
                    logoutUseCase.call(); // Perform logout
                    // onLogout(); // Notify MainNavigator
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainNavigator(),
                      ),
                      (route) => false, // Clear navigation stack
                    );
                    onLogout(); // Notify MainNavigator
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