import 'package:action_log_app/application/use_cases/hazard_use_cases/post_hazard_use_case.dart';
import 'package:action_log_app/application/use_cases/user_use_cases/clear_user_info_use_case.dart';
import 'package:action_log_app/application/use_cases/user_use_cases/fetch_user_info_use_case.dart';
import 'package:action_log_app/application/use_cases/user_use_cases/save_user_info_from_input_user_case.dart';
import 'package:action_log_app/core/di/features/hazard_di.dart';
import 'package:action_log_app/core/di/features/user_di.dart';
import 'package:action_log_app/domain/entities/user.dart';
import 'package:action_log_app/presentation/components/big_button.dart';
import 'package:action_log_app/presentation/pages/post_hazard_page.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../components/user_form_item.dart';

class UserInfoPage extends StatefulWidget {
  final FetchUserInfoUseCase fetchUserInfoUseCase;
  final SaveUserInfoFromInputUseCase saveUserInfoFromInputUseCase;
  final ClearUserInfoCacheUsecase clearUserInfoCacheUseCase;

  const UserInfoPage({
    super.key,
    required this.fetchUserInfoUseCase,
    required this.saveUserInfoFromInputUseCase,
    required this.clearUserInfoCacheUseCase,
  });

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  User user = User();
  final _userFormKey = GlobalKey<FormState>();
  late String username = ''; // Initialize with an empty string
  late String email = '';
  late String phoneNumber = '';

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
        username = user.username ?? '';
        email = user.email ?? '';
        phoneNumber = user.phoneNumber ?? '';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load user info: $e')),
      );
    }
  }


  void _continue() async {
    if (_userFormKey.currentState!.validate()) {
      await widget.saveUserInfoFromInputUseCase
          .call(username, email, phoneNumber);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PostHazardPage(
            postHazardUseCase: PostHazardUseCase(
              repository: HazardDI.repository,
              userLocalDataSource: UserDI.localDataSource,
            ),
            fetchUserInfoUseCase: widget.fetchUserInfoUseCase,
          ),
        ),
      );
    }
  }

bool get isActive => username.trim().isNotEmpty && email.trim().isNotEmpty && phoneNumber.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(IconsaxPlusLinear.arrow_left_1, color: black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('Мэдээлэл өгөх',
              style: TextStyle(
                  color: black, fontSize: 18, fontWeight: FontWeight.w500)),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32),
                Text( 
                  'Аюулыг илрүүлсэн мэдээллийн маягт', 
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                    )
                ),
                SizedBox(height: 16),
                Text( 
                  'Таны өгсөн мэдээллийг зөвхөн нислэгийн аюулгүй ажиллагаа, болон аюулгүй байдлыг дээшлүүлэхэд ашиглана.', 
                  style: TextStyle(
                    color: black,
                    fontSize: 14,
                    // fontWeight: FontWeight.w500
                    )
                ),
                SizedBox(height: 32),
                Text( 
                  'Холбогдох мэдээлэл', 
                  style: TextStyle(
                    color: black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                    )
                ),
                SizedBox(height: 8),
                Text( 
                  'Мэдээллийг тодруулах, авсан арга хэмжээний талаар эргэж мэдээллэх шаардлагатай тул та холбогдох мэдээллээ оруулна уу.', 
                  style: TextStyle(
                    color: black,
                    fontSize: 14,
                    // fontWeight: FontWeight.w500
                    )
                ),
                SizedBox(height: 24),
                Form(
                    key: _userFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        UserFormItem(
                          labelText: 'Овог, нэр',
                          iconData: IconsaxPlusLinear.user,
                          formValue: username,
                          onValueChanged: (val) {
                            setState(() {
                              username = val.trim();
                            });
                          },
                        ),
                        SizedBox(height: 12),
                        UserFormItem(
                          labelText: 'И-мэйл',
                          iconData: IconsaxPlusLinear.sms,
                          formValue: email,
                          onValueChanged: (val) {
                            setState(() {
                              email = val.trim();
                            });
                          },
                        ),
                        SizedBox(height: 12),
                        UserFormItem(
                          labelText: 'Утасны дугаар',
                          iconData: IconsaxPlusLinear.call,
                          formValue: phoneNumber,
                          onValueChanged: (val) {
                            setState(() {
                              phoneNumber = val.trim();
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Color(0xFF949494),
                                thickness: 2,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32.0),
                              child: Text(
                                'Эсвэл',
                                style: TextStyle(
                                  color: Color(0xFF949494),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Color(0xFF949494),
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Нэвтрэх',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline, 
                            decorationColor: primaryColor,
                          ),
                        ),
                        const SizedBox(height: 64),
                        BigButton(buttonText: 'Үргэлжлүүлэх', isActive: isActive, onTap: _continue,)
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
  }
}
