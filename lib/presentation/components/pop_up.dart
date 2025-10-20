import 'package:action_log_app/presentation/components/big_button.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:action_log_app/l10n/app_localizations.dart';

class PopUp extends StatelessWidget {
  final IconData icon;
  final String colorTheme;
  final String title;
  final String content;
  final bool hasTwoButtons;
  final VoidCallback onPress;

  const PopUp({
    required this.icon,
    required this.colorTheme,
    super.key,
    required this.title,
    this.content = '',
    this.hasTwoButtons = false,
    required this.onPress,
  });


  @override
  Widget build(BuildContext context) {

      var theColor;

      switch (colorTheme) {
        case 'danger':
          theColor = danger;
          break;
        case 'warning':
          theColor = warning;
          break;
        case 'success':
          theColor = success;
          break;
        default:
          theColor = Theme.of(context).primaryColor;
      }

    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      title: SizedBox(
        width: 360,
        child: Column(
          children: [
            Icon(
              icon,
              size: 56,
              color: theColor,
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 200,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.w600, 
                ),
              ),
            ),
          ],
        ),
      ),
      content: content.isEmpty
          ? null
          : SizedBox(
            width: 300,
            child: Text(
                content,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
          ),
      actions: hasTwoButtons
          ? [
              Column(
                children: [
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF292D32).withOpacity(0.15),
                                  spreadRadius: 0,
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                                BoxShadow(
                                  color: const Color(0xFF292D32).withOpacity(0.1),
                                  spreadRadius: 0,
                                  blurRadius: 25,
                                  offset: const Offset(4, 4),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical:  16.0),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.no,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: onPress,
                          child: Container(
                            decoration: BoxDecoration(
                              color: theColor,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF292D32).withOpacity(0.15),
                                  spreadRadius: 0,
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                                BoxShadow(
                                  color: const Color(0xFF292D32).withOpacity(0.1),
                                  spreadRadius: 0,
                                  blurRadius: 25,
                                  offset: const Offset(4, 4),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical:  16.0),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.yes,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ]
          : [
              Column(
                children: [
                  SizedBox(height: 16),
                  BigButton(
                    buttonText: AppLocalizations.of(context)!.ok,
                    isActive: true,
                    onTap: onPress
                  ),
                ],
              ),
            ],
    );
  }
}