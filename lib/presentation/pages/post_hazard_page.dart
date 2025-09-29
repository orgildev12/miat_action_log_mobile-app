import 'package:action_log_app/application/use_cases/hazard_use_cases/post_hazard_use_case.dart';
import 'package:action_log_app/application/use_cases/user_use_cases/fetch_user_info_use_case.dart';
import 'package:action_log_app/domain/entities/user.dart';
import 'package:action_log_app/models/post_hazard_model.dart';
import 'package:flutter/material.dart';

class HazardDetailsFormPage extends StatefulWidget {
  final PostHazardUseCase postHazardUseCase;
  final FetchUserInfoUseCase fetchUserInfoUseCase;

  const HazardDetailsFormPage({
    super.key,
    required this.postHazardUseCase,
    required this.fetchUserInfoUseCase,
  });

  @override
  State<HazardDetailsFormPage> createState() => _HazardDetailsFormPageState();
}

class _HazardDetailsFormPageState extends State<HazardDetailsFormPage> {
  User user = User();

  final _formKey = GlobalKey<FormState>();
  int? typeId;
  int? locationId;
  String? description;
  String? solution;

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
      });
    } catch (e) {
      // Handle error, e.g., show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load user info: $e')),
      );
    }
  }

void _submitHazard() {
  if (_formKey.currentState!.validate()) {
    final hazardModel = PostHazardModel(
      userId: user.id,
      userName: user.username,
      email: user.email,
      phoneNumber: user.phoneNumber,
      typeId: typeId!,
      locationId: locationId!,
      description: description ?? '',
      solution: solution ?? '',
    );
    // print('Hazard Model: $hazardModel');
    widget.postHazardUseCase.call(hazardModel, isUserLoggedIn: user.id != null);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Hazard submitted!')),
    );
    Navigator.pop(context);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hazard Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Type ID'),
                keyboardType: TextInputType.number,
                onChanged: (val) => typeId = int.tryParse(val),
                validator: (val) => val == null || val.isEmpty ? 'Enter type ID' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Location ID'),
                keyboardType: TextInputType.number,
                onChanged: (val) => locationId = int.tryParse(val),
                validator: (val) => val == null || val.isEmpty ? 'Enter location ID' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (val) => description = val,
                validator: (val) => val == null || val.isEmpty ? 'Enter description' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Solution'),
                onChanged: (val) => solution = val,
                validator: (val) => val == null || val.isEmpty ? 'Enter solution' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitHazard,
                child: const Text('Submit Hazard'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}