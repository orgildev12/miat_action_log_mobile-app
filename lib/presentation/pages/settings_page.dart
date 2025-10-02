import 'package:action_log_app/core/di/features/user_di.dart';
import 'package:action_log_app/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final VoidCallback onLogout; // Add a callback for logout

  const SettingsPage({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    final logoutUseCase = UserDI.logoutUseCase;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              logoutUseCase.call(); // Perform logout
              onLogout(); // Notify MainNavigator
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(isUserLoggedIn: false),
                ),
                (route) => false, // Clear navigation stack
              );
            },
            child: Text('Log out'),
          ),
        ],
      ),
    );
  }
}