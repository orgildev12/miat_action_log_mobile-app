import 'package:flutter/material.dart';
import 'package:action_log_app/presentation/styles/colors.dart';

class HelloText extends StatelessWidget {
  const HelloText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Icon(IconsaxPlusBold.headphone, size: 32, color: black,),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'lib/presentation/assets/images/pro.png',
            width: 36,
            height: 36,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Тавтай морил',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: black,
              ),
            ),
            Text(
              'Б.ОРГИЛ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: black,
              ),
            ),
          ],
        )
      ],
    );
  }
}
