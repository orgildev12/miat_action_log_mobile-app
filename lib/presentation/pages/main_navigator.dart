import 'package:action_log_app/core/di/features/user_di.dart';
import 'package:action_log_app/presentation/components/app_bar.dart';
import 'package:action_log_app/presentation/pages/home_page.dart';
import 'package:action_log_app/presentation/pages/my_hazards_page.dart';
import 'package:action_log_app/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  final ValueNotifier<bool> isLoggedInNotifier = ValueNotifier(false);
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeUserState();
  }

  Future<void> _initializeUserState() async {
    final fetchUserInfoUseCase = UserDI.fetchUserInfoUseCase;
    final user = await fetchUserInfoUseCase.call();
    isLoggedInNotifier.value = user.id != null; // Set login state based on user.id
  }

  @override
  Widget build(BuildContext context) {
    final body = [
      HomePage(isUserLoggedIn: isLoggedInNotifier.value),
      MyHazardsPage(),
      SettingsPage(
        onLogout: () {
          isLoggedInNotifier.value = false; // Update login state
        },
      ),
    ];

    return ValueListenableBuilder<bool>(
      valueListenable: isLoggedInNotifier,
      builder: (context, isUserLoggedIn, child) {
        return Scaffold(
          appBar: AppBar(
            title: ActionLogAppBar(isLoggedIn: isUserLoggedIn),
          ),
          body: SafeArea(
            top: true,
            child: body[_currentIndex],
          ),
          bottomNavigationBar: isUserLoggedIn
              ? BottomNavigationBar(
                  onTap: (tabIndex) {
                    setState(() {
                      _currentIndex = tabIndex;
                    });
                  },
                  currentIndex: _currentIndex,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.warning),
                      label: 'My Hazards',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: 'Settings',
                    ),
                  ],
                )
              : null, // Hide bottom navigation bar if not logged in
        );
      },
    );
  }

  @override
  void dispose() {
    isLoggedInNotifier.dispose();
    super.dispose();
  }
}