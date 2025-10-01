import 'package:action_log_app/application/use_cases/user_use_cases/login_user_case.dart';
import 'package:action_log_app/presentation/components/user_form_item.dart';
import 'package:action_log_app/presentation/components/big_button.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class LoginPage extends StatefulWidget {
  final LoginUseCase loginUseCase;

  const LoginPage({super.key, required this.loginUseCase});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  bool isLoading = false;
  String? errorMessage;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    try {
      await widget.loginUseCase.call(username, password);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Logged in successfully'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to login: $e';
        isLoading = false;
      });
    }
  }
  bool get isActive => username.trim().isNotEmpty && password.trim().isNotEmpty;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(IconsaxPlusLinear.arrow_left_1, color: black),
          onPressed: () => Navigator.of(context).pop(),
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
// onTap: () {
                //   widget.isUserLoggedIn ?
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => PostHazardPage(
                //         postHazardUseCase: PostHazardUseCase(
                //           repository: HazardDI.repository,
                //           userLocalDataSource: UserDI.localDataSource,
                //         ),
                //         fetchUserInfoUseCase: UserDI.fetchUserInfoUseCase,
                //       ),
                //     ),
                //   ) :
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) =>  UserInfoPage(
                //         fetchUserInfoUseCase: UserDI.fetchUserInfoUseCase,
                //         saveUserInfoFromInputUseCase: UserDI.saveUserInfoFromInput,
                //         clearUserInfoCacheUseCase: UserDI.clearUserInfoCacheUsecase,
                //       )),
                //   );
                // }