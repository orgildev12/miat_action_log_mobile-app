import 'package:action_log_app/application/use_cases/user_use_cases/fetch_user_info_use_case.dart';
import 'package:action_log_app/application/use_cases/user_use_cases/logout_user_use_case.dart';
import 'package:action_log_app/application/use_cases/user_use_cases/clear_user_info_use_case.dart';
import 'package:action_log_app/domain/entities/user.dart';
import 'package:flutter/material.dart';

class UserInfoPage extends StatefulWidget {
  final FetchUserInfoUseCase fetchUserInfoUseCase;
  final LogoutUseCase logoutUseCase;
  final ClearUserInfoCacheUsecase clearUserInfoCacheUsecase;

  const UserInfoPage({
    super.key,
    required this.fetchUserInfoUseCase,
    required this.logoutUseCase,
    required this.clearUserInfoCacheUsecase,
  });

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  User? user;
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final result = await widget.fetchUserInfoUseCase.call();
      setState(() {
        user = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load user info: $e';
        isLoading = false;
      });
    }
  }

  Future<void> _logout() async {
    try {
      await widget.logoutUseCase.call();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Logged out successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
      setState(() {
        user = null;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to logout: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _clearCache() async {
    try {
      await widget.clearUserInfoCacheUsecase.call();
      setState(() {
        user = null;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User cache cleared'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to clear cache: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: _logout,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Clear Cache',
            onPressed: _clearCache,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              errorMessage!,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchUserInfo,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (user == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_off,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              'No user info found',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please login or try again.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Welcome, ${user!.username}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              ElevatedButton.icon(
                onPressed: _fetchUserInfo,
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Refresh'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: Text(user!.id != null ? user!.id.toString() : '-'),
                subtitle: const Text('User ID'),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: Text(user!.username ?? '-'),
                subtitle: const Text('Username'),
              ),
              ListTile(
                leading: const Icon(Icons.email),
                title: Text(user!.email ?? '-'),
                subtitle: const Text('Email'),
              ),
              ListTile(
                leading: const Icon(Icons.phone),
                title: Text(user!.phoneNumber ?? '-'),
                subtitle: const Text('Phone Number'),
              ),
              ListTile(
                leading: const Icon(Icons.badge),
                title: Text(user!.fnameMn ?? '-'),
                subtitle: const Text('First Name (MN)'),
              ),
              ListTile(
                leading: const Icon(Icons.badge),
                title: Text(user!.lnameMn ?? '-'),
                subtitle: const Text('Last Name (MN)'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}