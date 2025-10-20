import 'package:action_log_app/core/di/features/user_di.dart';
import 'package:action_log_app/domain/entities/user.dart';
import 'package:action_log_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:get/get.dart';

class HelloText extends StatefulWidget {
  const HelloText({super.key});

  @override
  State<HelloText> createState() => _HelloTextState();
  
}

class _HelloTextState extends State<HelloText> {
  User? user;
  String? lastNameFirstCharacter;
  String? firstName;
  String? userName;
  String? languageCode = 'mn';

  @override
  void initState() {
    super.initState();
    loadUser();
  }

Future<void> loadUser() async {
  final fetchedUser = await UserDI.fetchUserInfoUseCase.call();
  userName = fetchedUser.lnameMn;
  final currentLocale = Get.locale;
  languageCode = currentLocale?.languageCode ?? 'mn';

  // Only update state if the widget is still mounted
    if (!mounted) return;

    setState(() {
      user = fetchedUser;
      if (languageCode == 'mn') {
        lastNameFirstCharacter = fetchedUser.lnameMn?[0];
        firstName = fetchedUser.fnameMn;
        userName = '$lastNameFirstCharacter. $firstName';
        return;
      }
      if (fetchedUser.lnameEn != null && fetchedUser.lnameEn!.isNotEmpty) {
        lastNameFirstCharacter = fetchedUser.lnameEn?[0];
        firstName = fetchedUser.fnameEn;
        userName = '$firstName .$lastNameFirstCharacter';
        return;
      }

      // fallback to Mongolian
      lastNameFirstCharacter = fetchedUser.lnameMn?[0];
      firstName = fetchedUser.fnameMn;
      userName = '$lastNameFirstCharacter. $firstName';
    });
  }


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
              AppLocalizations.of(context)!.welcome,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: black,
              ),
            ),
            Text(
              userName ?? '',
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
