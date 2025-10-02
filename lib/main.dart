import 'package:action_log_app/presentation/pages/main_navigator.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:action_log_app/core/di/dependency_injection.dart';

final ValueNotifier<bool> isLoggedInNotifier = ValueNotifier(false);

void main() async {
  // WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized
  DependencyInjection.setup();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {

  const MainApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isLoggedInNotifier,
      builder: (context, isLoggedIn, child) {
        return MaterialApp(
          title: 'Action Log App',
          theme: ThemeData(
            primaryColor: primaryColor,
            useMaterial3: true,
            scaffoldBackgroundColor: backgroundColor,
            appBarTheme: AppBarTheme(
              backgroundColor: backgroundColor,
              foregroundColor: white,
            ),
            textTheme: const TextTheme(
              titleLarge: TextStyle(color: black),
              bodyMedium: TextStyle(color: black),
            ),
          ),
          home: MainNavigator()
          // HomePage(isUserLoggedIn: isLoggedIn),
        );
      },
    );
  }
}
