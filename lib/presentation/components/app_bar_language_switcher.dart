import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:flutter/material.dart';

class LanguageSwitcher extends StatefulWidget {
  const LanguageSwitcher({super.key});

  @override
  State<LanguageSwitcher> createState() => _LanguageSwitcherState();
}

class _LanguageSwitcherState extends State<LanguageSwitcher> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFB2B2B2)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Prevent overflow
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 32,
            height: 16,
            child: Image.asset(
              'lib/presentation/assets/images/mongolia.png',
            ),
          ),
          SizedBox(width: 8),
          Icon(
            IconsaxPlusLinear.arrow_down,
            color: black, // Set icon color
            size: 24.0, // Set icon size
          ),
        ],
      ),
    );
  }
}