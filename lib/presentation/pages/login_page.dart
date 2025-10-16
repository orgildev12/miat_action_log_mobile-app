import 'package:action_log_app/application/controllers/auth_controller.dart';
import 'package:action_log_app/application/use_cases/user_use_cases/login_user_case.dart';
import 'package:action_log_app/core/di/features/user_di.dart';
import 'package:action_log_app/core/error/exceptions.dart';
import 'package:action_log_app/presentation/components/pop_up.dart';
import 'package:action_log_app/presentation/components/user_form_item.dart';
import 'package:action_log_app/presentation/components/big_button.dart';
import 'package:action_log_app/presentation/pages/main_navigator.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:action_log_app/l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  final LoginUseCase loginUseCase;
  const LoginPage({super.key, required this.loginUseCase});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // bool isUserLoggedIn =  isLoggedInNotifier.value;
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  bool isLoading = false;
  String? errorMessage;

  void _openErrorDialog(
    BuildContext context, {
    int? statusCode,
    String? dialogTitle,
    String? dialogDescription
  }) {
    String? title = dialogTitle;
    String? description = dialogDescription;
    
    if(statusCode != null){
        switch (statusCode) {
      case 401:
        title = AppLocalizations.of(context)!.warning;
        description = AppLocalizations.of(context)!.incorrectUserPass;
        break;
      case 503:
        title = AppLocalizations.of(context)!.weAreSorry;
        description = AppLocalizations.of(context)!.description503;
        break;
      default:
        title = AppLocalizations.of(context)!.sorry;
        description = AppLocalizations.of(context)!.description500;
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopUp(
          icon: IconsaxPlusLinear.close_circle,
          colorTheme: 'danger',
          title: title ?? 'Уучлаарай',
          content: description ?? 'Алдаа гарлаа. Дахин оролдоно уу',
          onPress: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  AuthController authController = UserDI.controller;
  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    try {
      await authController.login(username, password);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.loginSuccess),
            backgroundColor: Colors.green,
          ),
        );
        await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MainNavigator(),
          ),
          (route) => false, // Clear navigation stack
        );
        final authController = UserDI.controller;
        authController.isLoggedIn.value = true;
      }
    } on SocketException {
      if (mounted) {
        _openErrorDialog(
          context, 
          dialogTitle: AppLocalizations.of(context)!.warning, 
          dialogDescription: AppLocalizations.of(context)!.noInternet,
        );
      }
    } on ServerException catch (e) {
      if (mounted) {
        _openErrorDialog( context, statusCode: e.statusCode);
      }
    }finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  bool get isActive => username.trim().isNotEmpty && password.trim().isNotEmpty;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(IconsaxPlusLinear.arrow_left_1, color: black),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Нэвтрэх',
          style: TextStyle(
            color: black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'lib/presentation/assets/images/action_log_banner.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 64),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (errorMessage != null)
                    Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  UserFormItem(
                    labelText: 'Хэрэглэгчийн нэр',
                    iconData: IconsaxPlusLinear.user,
                    onValueChanged: (val) => setState(() => username = val),
                    formValue: username,
                  ),
                  SizedBox(height: 8),
                  UserFormItem(
                    labelText: 'Нууц үг',
                    iconData: IconsaxPlusLinear.key,
                    onValueChanged: (val) => setState(() => password = val),
                    formValue: password,
                    isPassword: true,
                  ),
                  const SizedBox(height: 64),
                  isLoading
                      ? const CircularProgressIndicator()
                      : BigButton(
                          buttonText: 'Нэвтрэх', 
                          isActive: isActive,
                          onTap: _login,
                          )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}