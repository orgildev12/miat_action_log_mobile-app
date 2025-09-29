import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class SmallTextButton extends StatelessWidget {
  const SmallTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        gradient: mainGradient,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center content
          children: const [
            Text(
              'Нэвтрэх',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: white,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              IconsaxPlusLinear.login,
              color: white,
              size: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
