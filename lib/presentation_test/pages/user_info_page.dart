import 'package:action_log_app/application/use_cases/hazard_use_cases/post_hazard_use_case.dart';
import 'package:action_log_app/application/use_cases/user_use_cases/clear_user_info_use_case.dart';
import 'package:action_log_app/application/use_cases/user_use_cases/fetch_user_info_use_case.dart';
import 'package:action_log_app/application/use_cases/user_use_cases/save_user_info_from_input_user_case.dart';
import 'package:action_log_app/core/di/features/hazard_di.dart';
import 'package:action_log_app/core/di/features/user_di.dart';
import 'package:action_log_app/domain/entities/user.dart';
import 'package:action_log_app/presentation_test/pages/post_hazard_page.dart';
import 'package:flutter/material.dart';

class UserInfoPageForm extends StatefulWidget {
  final FetchUserInfoUseCase fetchUserInfoUseCase;
  final SaveUserInfoFromInputUseCase saveUserInfoFromInputUseCase;
  final ClearUserInfoCacheUsecase clearUserInfoCacheUseCase;

  const UserInfoPageForm({
    super.key,
    required this.fetchUserInfoUseCase,
    required this.saveUserInfoFromInputUseCase,
    required this.clearUserInfoCacheUseCase,
    });

  @override
  State<UserInfoPageForm> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPageForm> {
  User user = User();
  final _userFormKey = GlobalKey<FormState>();
  late String username;
  late String email;
  late String phoneNumber;

@override void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    try {
      final fetchedUser = await widget.fetchUserInfoUseCase.call();
      setState(() {
        user = fetchedUser;
        username = user.username ?? '';
        email = user.email ?? '';
        phoneNumber = user.phoneNumber ?? '';
      });
    } catch (e) {
      // Handle error, e.g., show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load user info: $e')),
      );
    }
  }

  void _continue() async {
    if (_userFormKey.currentState!.validate()) {
      await widget.saveUserInfoFromInputUseCase.call(username, email, phoneNumber);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HazardDetailsFormPage(
            postHazardUseCase: PostHazardUseCase(
              repository: HazardDI.repository,
              userLocalDataSource: UserDI.localDataSource, // <-- FIXED HERE
            ),
            fetchUserInfoUseCase: widget.fetchUserInfoUseCase,
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User info saved! Continue to hazard details.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _userFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Username'),
                onChanged: (val) => username = val,
                validator: (val) => val == null || val.isEmpty ? 'Enter username' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (val) => email = val,
                validator: (val) => val == null || val.isEmpty ? 'Enter email' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                onChanged: (val) => phoneNumber = val,
                validator: (val) => val == null || val.isEmpty ? 'Enter phone number' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _continue,
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}