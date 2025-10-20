import 'package:action_log_app/application/controllers/language_controller.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';

class LanguageSwitcher extends StatefulWidget {
  const LanguageSwitcher({super.key});

  @override
  State<LanguageSwitcher> createState() => _LanguageSwitcherState();
}

class _LanguageSwitcherState extends State<LanguageSwitcher> {
  String? languageCode = 'mn';

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: LocaleController().switchLocale,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(230, 255, 255, 255),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                Localizations.localeOf(context).languageCode == 'mn'
                    ? 'lib/presentation/assets/images/mongolian_flag_circle.png'
                    : 'lib/presentation/assets/images/british_flag_circle.png',
                width: 24,
                height: 24,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 4),
            SizedBox(
              width:24,
              child: Align(
                alignment: AlignmentGeometry.centerRight,
                child: Text(
                  Localizations.localeOf(context).languageCode == 'mn' ? 'MN' : 'EN',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
