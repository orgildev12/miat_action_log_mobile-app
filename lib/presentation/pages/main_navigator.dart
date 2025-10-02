import 'package:action_log_app/core/di/features/user_di.dart';
import 'package:action_log_app/main.dart';
import 'package:action_log_app/presentation/components/app_bar.dart';
import 'package:action_log_app/presentation/pages/home_page.dart';
import 'package:action_log_app/presentation/pages/my_hazards_page.dart';
import 'package:action_log_app/presentation/pages/settings_page.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
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
                  showSelectedLabels: false, // Hide labels for selected items
                  showUnselectedLabels: false, // Hide labels for unselected items
                  selectedItemColor: black,
                  // unselectedItemColor: ,
                  items: [
                    BottomNavigationBarItem(
                      icon: _currentIndex == 0 ?
                      Icon(IconsaxPlusBold.home_2, size: 28) : 
                      Icon(IconsaxPlusLinear.home_2, size: 28),

                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: _currentIndex == 1 ?
                      Icon(
                        IconsaxPlusBold.note_text,
                        size: 28,
                      )
                      : Icon(
                        IconsaxPlusLinear.note_text,
                        size: 28,
                      ),
                      label: 'My Hazards',
                    ),
                    BottomNavigationBarItem(
                      icon: _currentIndex == 2 ?
                      Icon(IconsaxPlusBold.user_square, size: 28) : 
                      Icon(IconsaxPlusLinear.user_square, size: 28),
                      label: 'Settings',
                    ),
                  ],
                )
              : null, // Hide bottom navigation bar if not logged in
        );
      },
    );
  }
}