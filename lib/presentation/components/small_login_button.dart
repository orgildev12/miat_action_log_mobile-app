import 'package:action_log_app/l10n/app_localizations.dart';
import 'package:action_log_app/presentation/components/login_pop_up.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
// import 'package:action_log_app/presentation/components/pop_up.dart';

class SmallLoginButton extends StatefulWidget {
  const SmallLoginButton({
    super.key,
  });

  @override
  State<SmallLoginButton> createState() => _SmallLoginButtonState();
}

class _SmallLoginButtonState extends State<SmallLoginButton> {
  String? languageCode = 'mn';

  @override
  void initState() {
    super.initState();
    final currentLocale = Get.locale ;
    languageCode = currentLocale?.languageCode ?? 'mn';
  }    

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          gradient: mainGradient,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextButton(
          onPressed: (){
            showDialog(
              context: context, 
              builder: (BuildContext context) => const LoginPopUp(),
              );
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center content
            children: [
              Text(
                AppLocalizations.of(context)!.login,
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
      ),
    );
  }
}
