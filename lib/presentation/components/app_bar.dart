import 'package:action_log_app/presentation/components/app_bar_hello_text.dart';
import 'package:action_log_app/presentation/components/app_bar_language_switcher.dart';
import 'package:action_log_app/presentation/components/small_text_button.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class ActionLogAppBar extends StatefulWidget {
  const ActionLogAppBar({super.key, required this.isLoggedIn});
  final bool isLoggedIn;

  @override
  State<ActionLogAppBar> createState() => _ActionLogAppBarState();
}

class _ActionLogAppBarState extends State<ActionLogAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
          // height: 100,
          color: white,
          alignment: Alignment.center,
          child: 
          Padding(padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 16),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: widget.isLoggedIn
                  ? [
                      HelloText(),
                      Row(
                        children: [
                          LanguageSwitcher(),
                          const SizedBox(width: 16),
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
                          SmallTextButton()
                        ],
                      ),
                    ],
            ),
          ),

        );
  }
}