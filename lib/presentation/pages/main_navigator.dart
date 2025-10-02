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

  Widget _buildBottomNavigationBar(bool isUserLoggedIn) {
    final items = isUserLoggedIn
        ? [
            BottomNavigationBarItem(
              icon: Icon(
                _currentIndex == 0 ? IconsaxPlusBold.home_2 : IconsaxPlusLinear.home_2,
                size: 28,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _currentIndex == 1 ? IconsaxPlusBold.note_text : IconsaxPlusLinear.note_text,
                size: 28,
              ),
              label: 'My Hazards',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _currentIndex == 2 ? IconsaxPlusBold.category : IconsaxPlusLinear.category,
                size: 28,
              ),
              label: 'Settings',
            ),
          ]
        : [
            BottomNavigationBarItem(
              icon: Icon(
                _currentIndex == 0 ? IconsaxPlusBold.home_2 : IconsaxPlusLinear.home_2,
                size: 28,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _currentIndex == 1 ? IconsaxPlusBold.category : IconsaxPlusLinear.category,
                size: 28,
              ),
              label: 'Settings',
            ),
          ];

    return BottomNavigationBar(
      onTap: (tabIndex) {
        setState(() {
          _currentIndex = tabIndex;
        });
      },
      currentIndex: _currentIndex,
      showSelectedLabels: false, // Hide labels for selected items
      showUnselectedLabels: false, // Hide labels for unselected items
      selectedItemColor: black,
      items: items,
    );
  }

  @override
  Widget build(BuildContext context) {
    final loggedInBody = [
      HomePage(isUserLoggedIn: isLoggedInNotifier.value),
      MyHazardsPage(),
      SettingsPage(
        onLogout: () {
          isLoggedInNotifier.value = false; // Update login state
        },
      ),
    ];

    final loggedOutBody = [
      HomePage(isUserLoggedIn: isLoggedInNotifier.value),
      SettingsPage(
        onLogout: () {
          isLoggedInNotifier.value = false; // Update login state
        },
      ),
    ];

    return ValueListenableBuilder<bool>(
      valueListenable: isLoggedInNotifier,
      builder: (context, isUserLoggedIn, child) {
        // Adjust _currentIndex only if it is out of bounds for the current state
        if (!isUserLoggedIn && _currentIndex >= loggedOutBody.length) {
          _currentIndex = loggedOutBody.length - 1; // Set to the last valid index
        }

        return Scaffold(
          appBar: AppBar(
            title: ActionLogAppBar(isLoggedIn: isUserLoggedIn),
          ),
          body: SafeArea(
            top: true,
            child: isUserLoggedIn
                ? loggedInBody[_currentIndex]
                : loggedOutBody[_currentIndex],
          ),
          bottomNavigationBar: _buildBottomNavigationBar(isUserLoggedIn),
        );
      },
    );
  }
}