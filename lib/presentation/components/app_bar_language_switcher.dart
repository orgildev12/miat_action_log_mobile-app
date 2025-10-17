import 'package:action_log_app/presentation/styles/colors.dart';
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
        color: const Color.fromARGB(230, 255, 255, 255),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child:  Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'lib/presentation/assets/images/mongolian_flag_circle.png',
              width: 24,
              height: 24,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 8,),
          Text(
            'MN',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: black,
            ),
          ),
        ],
      )
    );
  }
}