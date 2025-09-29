import 'package:action_log_app/presentation/components/app_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(64.0), // Set the height of the AppBar
        child: AppBar(
          title: ActionLogAppBar(isLoggedIn: true)
        ),
      ),
      body: SafeArea(
        top: true, // Use SafeArea for top padding
        child: SingleChildScrollView(
          child: Column(
            children: const [
              Text('Welcome to the Action Log App!'),
              // Add more widgets here as needed
            ],
          ),
        ),
      ),
    );
  }
}