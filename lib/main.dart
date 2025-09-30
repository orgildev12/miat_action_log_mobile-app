import 'package:action_log_app/application/use_cases/user_use_cases/fetch_user_info_use_case.dart';
import 'package:action_log_app/core/di/features/user_di.dart';
import 'package:action_log_app/presentation/pages/home_page.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:action_log_app/core/di/dependency_injection.dart';

final ValueNotifier<bool> isLoggedInNotifier = ValueNotifier(false);

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized
  DependencyInjection.setup();

  final fetchUserInfoUseCase = UserDI.fetchUserInfoUseCase;
  final user = await fetchUserInfoUseCase.call();
  isLoggedInNotifier.value = user.id != null; // Set login state based on user.id

  runApp(MainApp(fetchUserInfoUseCase: fetchUserInfoUseCase));
}

class MainApp extends StatelessWidget {
  final FetchUserInfoUseCase fetchUserInfoUseCase;

  const MainApp({
    super.key,
    required this.fetchUserInfoUseCase,
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
          home: HomePage(isUserLoggedIn: isLoggedIn),
        );
      },
    );
  }
}
