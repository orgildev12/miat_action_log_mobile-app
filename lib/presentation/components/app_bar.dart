import 'package:action_log_app/application/use_cases/user_use_cases/fetch_user_info_use_case.dart';
import 'package:action_log_app/core/di/features/user_di.dart';
import 'package:action_log_app/presentation/components/app_bar_hello_text.dart';
import 'package:action_log_app/presentation/components/app_bar_language_switcher.dart';
import 'package:action_log_app/presentation/components/small_login_button.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class ActionLogAppBar extends StatefulWidget {
  ActionLogAppBar({super.key, required this.isLoggedIn});
  final bool isLoggedIn;
  final FetchUserInfoUseCase fetchUserInfoUseCase = UserDI.fetchUserInfoUseCase;

  @override
  State<ActionLogAppBar> createState() => _ActionLogAppBarState();
}

class _ActionLogAppBarState extends State<ActionLogAppBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
          // height: 100,
          color: backgroundColor,
          alignment: Alignment.center,
          child: 
          Padding(padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 24),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: widget.isLoggedIn
                  ? [
                      HelloText(),
                      Row(
                        children: [
                          LanguageSwitcher(),
                          const SizedBox(width: 24),
                          Icon(
                            IconsaxPlusLinear.notification,
                            color: black, // Set icon color
                            size: 24.0, // Set icon size
                          ),
                        ],
                      ),
                    ]
                  : [
                      const SizedBox(), // Empty space when not logged in
                      Row(
                        children: [
                          LanguageSwitcher(),
                          const SizedBox(width: 12),
                          SmallLoginButton(),
                        ],
                      ),
                    ],
            ),
          ),

        );
  }
}