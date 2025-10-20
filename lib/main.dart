import 'package:action_log_app/core/di/app_di.dart';
import 'package:action_log_app/core/di/features/hazard_di.dart';
import 'package:action_log_app/core/di/features/hazard_type_di.dart';
import 'package:action_log_app/core/di/features/location_di.dart';
import 'package:action_log_app/data/data_sources/language_code.dart';
import 'package:action_log_app/l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:action_log_app/l10n/app_localizations.dart';
import 'package:action_log_app/presentation/pages/main_navigator.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:action_log_app/core/di/core_di.dart';
import 'package:action_log_app/core/di/features/user_di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  CoreDI.setup();
  UserDI.setup();
  LocationDI.setup();
  HazardTypeDI.setup();
  HazardDI.setup();
  AppDI.setup();
  UserDI.controller.recoverToken(true);

  String savedLang = await loadLanguage();
  runApp(MainApp(initialLanguage: savedLang));
}

class MainApp extends StatelessWidget {
  final String initialLanguage;
  const MainApp({
    super.key,
    required this.initialLanguage
    });
  
  @override
  Widget build(BuildContext context) {
    final authController = UserDI.controller;
    
    return Listener(
      // User activity → IdleManager reset
      onPointerDown: (_) => authController.userActivityDetected(),
      // onPointerMove: (_) => authController.userActivityDetected(),
      // onPointerUp: (_) => authController.userActivityDetected(),
      child: ValueListenableBuilder<bool>(
        valueListenable: authController.isLoggedIn,
        builder: (context, isLoggedIn, child) {
          return GetMaterialApp(
            title: 'Action Log App',
            theme: ThemeData(
              primaryColor: primaryColor,
              useMaterial3: true,
              scaffoldBackgroundColor: backgroundColor,
              appBarTheme: AppBarTheme(
                backgroundColor: backgroundColor,
                foregroundColor: Colors.white,
              ),
              textTheme: const TextTheme(
                titleLarge: TextStyle(color: Colors.black),
                bodyMedium: TextStyle(color: Colors.black),
              ),
            ),
            supportedLocales: L10n.all,
            locale: Locale(initialLanguage),
            fallbackLocale: Locale('mn'),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            home: const MainNavigator(),
          );
        },
      ),
    );
  }
}
