import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class SettingsPageItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final bool isRed;
  final bool hasNoTrailingIcon;

  const SettingsPageItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isRed = false,
    this.hasNoTrailingIcon = false,
    });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: TextStyle(
        color: black,
        fontSize: 16,
        // fontWeight: FontWeight.w500
      ),),
      leading: isRed ? Icon(icon, color: Colors.red, size: 20,) : Icon(icon, color: black, size: 20),
      onTap: onTap,
      trailing: hasNoTrailingIcon ? null : Icon( IconsaxPlusLinear.arrow_right_3, size: 24, color: black),
    );
  }
}