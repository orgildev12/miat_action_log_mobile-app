import 'package:action_log_app/l10n/app_localizations.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(IconsaxPlusLinear.arrow_left_1, color: black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            AppLocalizations.of(context)!.notifications,
            style: TextStyle(
              color: black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body:  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250,
                  child: Image.asset(
                      'lib/presentation/assets/images/empty_box.png',
                      fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: 250,
                  child: Text(
                    AppLocalizations.of(context)!.youDontHaveNotif,
                    textAlign: TextAlign.center, 
                    style: TextStyle(
                      fontSize:20, 
                      fontWeight: FontWeight.w500, 
                      color: hintText
                    )
                  ),
                ),
              ],
            ),
          ),
    );
  }
}