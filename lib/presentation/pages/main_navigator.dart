import 'package:action_log_app/core/di/features/user_di.dart';
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
  final authController = UserDI.controller;
  bool isUserLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _initializeUserState();
  }

  Future<void> _initializeUserState() async {
    final user = await UserDI.fetchUserInfoUseCase.call();
    bool isThereUserId = authController.isLoggedIn.value = user.id != null;
    setState(() {
      isUserLoggedIn = isThereUserId;
    });
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
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: black,
      items: items,
    );
  }

  @override
  Widget build(BuildContext context) {
    final loggedInBody = [
      HomePage(isUserLoggedIn: isUserLoggedIn),
      MyHazardsPage(),
      SettingsPage(
        onLogout: () async {
          await authController.logout();
        },
      ),
    ];

    final loggedOutBody = [
      HomePage(isUserLoggedIn: isUserLoggedIn),
      SettingsPage(
        onLogout: () async {
          await authController.logout();
        },
      ),
    ];

    return ValueListenableBuilder<bool>(
      valueListenable: authController.isLoggedIn,
      builder: (context, isUserLoggedIn, child) {
        if (!isUserLoggedIn && _currentIndex >= loggedOutBody.length) {
          _currentIndex = loggedOutBody.length - 1;
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
