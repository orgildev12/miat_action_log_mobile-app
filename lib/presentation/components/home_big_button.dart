import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class HomeBigButton extends StatelessWidget {
  final bool isColored;
  final String buttonText;
  final IconData buttonIcon;
  final bool otherRecources;
  final VoidCallback? onTap;

  const HomeBigButton({
    super.key,
    required this.isColored,
    required this.buttonText,
    required this.buttonIcon,
    this.otherRecources = false,
    this.onTap,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: isColored ? mainGradient : null,
            color: isColored ? null : Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF292D32).withOpacity(0.15),
                spreadRadius: 0,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
              BoxShadow(
                color: Color(0xFF292D32).withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 25,
                offset: Offset(4, 4),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                otherRecources ?
                Row(
                  children: [
                    Text(
                    buttonText,
                    style: TextStyle(
                      color: isColored ? Colors.white : black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      IconsaxPlusLinear.call,
                      color: black,
                      size: 20.0,
                    ),
                    SizedBox(width: 4),
                    Icon(
                      IconsaxPlusLinear.sms,
                      color: black,
                      size: 20.0,
                    ),
                    SizedBox(width: 4),
                    Icon(
                      IconsaxPlusLinear.global,
                      color: black,
                      size: 20.0,
                    ),
                  ],
                )
                :
                Text(
                  buttonText,
                  style: TextStyle(
                    color: isColored ? Colors.white : black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),


                Icon(
                  buttonIcon,
                  color: isColored ? Colors.white : black,
                  size: 24.0,
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}