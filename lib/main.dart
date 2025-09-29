import 'package:action_log_app/presentation/pages/home_page.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:action_log_app/core/di/dependency_injection.dart';
void main() {
  DependencyInjection.setup();
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Action Log App',
      theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: white,
        foregroundColor: white,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: black),
        bodyMedium: TextStyle(color: black),
      ),
    ),
      home: const HomePage(),

    );
  }
}
