import 'package:flutter/material.dart';
import 'package:action_log_app/presentation/pages/location_groups_page.dart';
import 'package:action_log_app/core/di/dependency_injection.dart';
import 'package:action_log_app/core/di/features/location_group_di.dart';

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
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: LocationGroupsPage(
        // Access through feature-specific DI
        fetchLocationGroupsUseCase: LocationGroupDI.fetchLocationGroupsUseCase,
      ),
    );
  }
}
