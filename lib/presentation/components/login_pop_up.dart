import 'package:action_log_app/core/di/features/user_di.dart';
import 'package:action_log_app/l10n/app_localizations.dart';
import 'package:action_log_app/presentation/components/big_button.dart';
import 'package:action_log_app/presentation/pages/login_page.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class LoginPopUp extends StatelessWidget {
  const LoginPopUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void _pushToLogin(BuildContext context) async {
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => LoginPage(
            loginUseCase: UserDI.loginUseCase,
          ),
        ),
      );
    }

    return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        title: SizedBox(
          width: 360,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                IconsaxPlusLinear.info_circle,
                size: 24,
                color: black,
              ),
              const SizedBox(width: 8),
              SizedBox(
                child: Text(
                  AppLocalizations.of(context)!.warning,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        content: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.loginPopUpDesc1,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.loginPopUpDesc1,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
        actions: [
          Column(
            children: [
              SizedBox(height: 16),
              BigButton(
                  buttonText: AppLocalizations.of(context)!.ok, 
                  isActive: true, 
                  onTap: () => Navigator.of(context).pop()
              ),
              SizedBox(height: 8),
              TextButton(
                onPressed: () => _pushToLogin(context),
                child: Text(AppLocalizations.of(context)!.login,
                    style: TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                    decorationColor: primaryColor,
                    ),
                  ),
              )
            ],
          ),
        ]);
  }
}
