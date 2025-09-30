import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';

class AddImageButton extends StatelessWidget {
  final String buttonText;
  final IconData iconData;
  final VoidCallback? onTap;
  const AddImageButton({
    super.key,
    required this.buttonText,
    required this.iconData,
    this.onTap,
    });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white, // Set the background color to white
          // border: Border.all(color: Colors.grey),
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
            )]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, color: black, size: 24,),
            SizedBox(width: 12),
            Text(buttonText, style: TextStyle(color: black, fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}