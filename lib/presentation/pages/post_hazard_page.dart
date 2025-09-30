import 'package:action_log_app/application/use_cases/hazard_use_cases/post_hazard_use_case.dart';
import 'package:action_log_app/application/use_cases/user_use_cases/fetch_user_info_use_case.dart';
import 'package:action_log_app/domain/entities/user.dart';
import 'package:action_log_app/models/post_hazard_model.dart';
import 'package:action_log_app/presentation/components/add_image_button.dart';
import 'package:action_log_app/presentation/components/hazard_form_item.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class PostHazardPage extends StatefulWidget {
  final PostHazardUseCase postHazardUseCase;
  final FetchUserInfoUseCase fetchUserInfoUseCase;

  const PostHazardPage({
    super.key,
    required this.postHazardUseCase,
    required this.fetchUserInfoUseCase,
  });

  @override
  State<PostHazardPage> createState() => _PostHazardPageState();
}

class _PostHazardPageState extends State<PostHazardPage> {
  User user = User();

  final _formKey = GlobalKey<FormState>();
  int? typeId;
  int? locationId;
  String? description;
  String? solution;

  late String username;
  late String email;
  late String phoneNumber;

  @override
  void initState() {
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
      widget.postHazardUseCase
          .call(hazardModel, isUserLoggedIn: user.id != null);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hazard submitted!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(IconsaxPlusLinear.arrow_left_1, color: black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Мэдээлэл өгөх',
          style: TextStyle(
            color: black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32),
              Text('Аюулыг илрүүлсэн мэдээллийн маягт',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              SizedBox(height: 16),
              Text(
                'Таны өгсөн мэдээллийг зөвхөн нислэгийн аюулгүй ажиллагаа, болон аюулгүй байдлыг дээшлүүлэхэд ашиглана.',
                style: TextStyle(
                  color: black,
                  fontSize: 14,
                )
              ),
              SizedBox(height: 32),
              HazardFormItem(
                hintText: 'Байршил сонгох',
                labelText: 'Байршил',
                formValue: locationId?.toString() ?? '',
                onValueChanged: (val) => setState(() {
                  locationId = int.tryParse(val);
                }),
              ),
              SizedBox(height: 24),
              HazardFormItem(
                labelText: 'Дэлгэрэнгүй мэдээлэл',
                hintText: 'Аюул, зөрчил эсвэл алдааны талаар дэлгэрэнгүй тайлбарлана уу.',
                formValue: locationId?.toString() ?? '',
                onValueChanged: (val) => setState(() {
                  locationId = int.tryParse(val);
                }),
              ),
              SizedBox(height: 24),
              HazardFormItem(
                labelText: 'Эрсдэлийг бууруулах, арилгах талаар санал',
                hintText: 'Ийм алдаа дахин давтагдахаас сэргийлж юу хийж болох талаар саналаа бичнэ үү.',
                formValue: locationId?.toString() ?? '',
                onValueChanged: (val) => setState(() {
                  locationId = int.tryParse(val);
                }),
              ),
              SizedBox(height: 24),
              Text('Зураг', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: black)),
              SizedBox(height: 12),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: AddImageButton(
                      buttonText: 'Зураг дарах', 
                      iconData: IconsaxPlusLinear.camera,)
                  ),
                  SizedBox(width: 16),
                  Flexible(
                    flex: 1,
                    child: AddImageButton(
                      buttonText: 'Зураг оруулах', 
                      iconData: IconsaxPlusLinear.paperclip_2,)
                  ),

                ],
              ),

              SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Type ID'),
                      keyboardType: TextInputType.number,
                      onChanged: (val) => typeId = int.tryParse(val),
                      validator: (val) =>
                          val == null || val.isEmpty ? 'Enter type ID' : null,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Location ID'),
                      keyboardType: TextInputType.number,
                      onChanged: (val) => locationId = int.tryParse(val),
                      validator: (val) =>
                          val == null || val.isEmpty ? 'Enter location ID' : null,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Description'),
                      onChanged: (val) => description = val,
                      validator: (val) =>
                          val == null || val.isEmpty ? 'Enter description' : null,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Solution'),
                      onChanged: (val) => solution = val,
                      validator: (val) =>
                          val == null || val.isEmpty ? 'Enter solution' : null,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _submitHazard,
                      child: const Text('Submit Hazard'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
