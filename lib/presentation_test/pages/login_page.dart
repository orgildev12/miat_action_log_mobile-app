import 'package:action_log_app/application/use_cases/user_use_cases/login_user_case.dart';
import 'package:flutter/material.dart';

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
        Navigator.pop(context); // Go back to previous page
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to login: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
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
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Username'),
                  onChanged: (val) => username = val,
                  validator: (val) => val == null || val.isEmpty ? 'Enter username' : null,
                  autofillHints: const [], // <-- Disable autofill
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onChanged: (val) => password = val,
                  validator: (val) => val == null || val.isEmpty ? 'Enter password' : null,
                  autofillHints: const [], // <-- Disable autofill
                ),
              const SizedBox(height: 24),
              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _login,
                      child: const Text('Login'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}