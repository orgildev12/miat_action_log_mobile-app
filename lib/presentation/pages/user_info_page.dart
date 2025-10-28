import 'package:action_log_app/application/use_cases/hazard_use_cases/post_hazard_use_case.dart';
import 'package:action_log_app/application/use_cases/user_use_cases/clear_user_info_use_case.dart';
import 'package:action_log_app/application/use_cases/user_use_cases/fetch_user_info_use_case.dart';
import 'package:action_log_app/application/use_cases/user_use_cases/save_user_info_from_input_user_case.dart';
import 'package:action_log_app/core/di/features/hazard_di.dart';
import 'package:action_log_app/core/di/features/user_di.dart';
import 'package:action_log_app/domain/entities/user.dart';
import 'package:action_log_app/l10n/app_localizations.dart';
import 'package:action_log_app/presentation/components/big_button.dart';
import 'package:action_log_app/presentation/components/login_pop_up.dart';
import 'package:action_log_app/presentation/pages/post_hazard_page.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../components/user_form_item.dart';

class UserInfoPage extends StatefulWidget {
  final FetchUserInfoUseCase fetchUserInfoUseCase;
  final SaveUserInfoFromInputUseCase saveUserInfoFromInputUseCase;
  final ClearUserInfoCacheUsecase clearUserInfoCacheUseCase;
  final int hazardTypeId;
  final String hazardTypeName;

  const UserInfoPage({
    super.key,
    required this.fetchUserInfoUseCase,
    required this.saveUserInfoFromInputUseCase,
    required this.clearUserInfoCacheUseCase,
    required this.hazardTypeId,
    required this.hazardTypeName,
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
            hazardTypeId: widget.hazardTypeId,
            hazardTypeName: widget.hazardTypeName,
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
          title:  Text(AppLocalizations.of(context)!.reportHazard,
              style: TextStyle(
                  color: black, fontSize: 18, fontWeight: FontWeight.w500)),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 32),
                  Text( 
                    widget.hazardTypeName, 
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                      )
                  ),
                  SizedBox(height: 16),
                  Text( 
                    AppLocalizations.of(context)!.weWillUseThisForOnly,
                    style: TextStyle(
                      color: black,
                      fontSize: 14,
                      // fontWeight: FontWeight.w500
                      )
                  ),
                  SizedBox(height: 32),
                  Text( 
                    AppLocalizations.of(context)!.contactInfo, 
                    style: TextStyle(
                      color: black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                      )
                  ),
                  SizedBox(height: 8),
                  Text( 
                    AppLocalizations.of(context)!.weNeedToAskYou, 
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
                            labelText: AppLocalizations.of(context)!.fullName,
                            iconData: IconsaxPlusLinear.user,
                            keyboardType: TextInputType.name,
                            formValue: username,
                            onValueChanged: (val) {
                              setState(() {
                                username = val.trim();
                              });
                            },
                          ),
                          SizedBox(height: 12),
                          UserFormItem(
                            labelText: AppLocalizations.of(context)!.email,
                            iconData: IconsaxPlusLinear.sms,
                            keyboardType: TextInputType.emailAddress,
                            formValue: email,
                            onValueChanged: (val) {
                              setState(() {
                                email = val.trim();
                              });
                            },
                          ),
                          SizedBox(height: 12),
                          UserFormItem(
                            labelText: AppLocalizations.of(context)!.phone,
                            iconData: IconsaxPlusLinear.call,
                            keyboardType: TextInputType.phone,
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
                                  AppLocalizations.of(context)!.or,
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
                          // const SizedBox(height: 16),
                          TextButton(
                            onPressed: (){
                              showDialog(
                                context: context, 
                                builder: (BuildContext context) => const LoginPopUp(),
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)!.login,
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline, 
                                decorationColor: primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          BigButton(buttonText: AppLocalizations.of(context)!.continueee, isActive: isActive, onTap: _continue,),
                          SizedBox(height: 64),
                        ],
                      ),
                    ),
                ],
              ),
            ),
        ),
        );
  }
}
