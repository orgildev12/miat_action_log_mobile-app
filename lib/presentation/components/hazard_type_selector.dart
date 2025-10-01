import 'package:action_log_app/application/use_cases/hazard_use_cases/post_hazard_use_case.dart';
import 'package:action_log_app/core/di/features/hazard_di.dart';
import 'package:action_log_app/core/di/features/user_di.dart';
import 'package:action_log_app/domain/entities/hazard_type.dart';
import 'package:action_log_app/presentation/pages/post_hazard_page.dart';
import 'package:action_log_app/presentation/pages/user_info_page.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class HazardTypeSelector extends StatelessWidget {
  final HazardType hazardType;
  final bool isUserLoggedIn;

  const HazardTypeSelector({
    super.key,
    required this.hazardType,
    required this.isUserLoggedIn,
    });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(hazardType.nameMn),
      trailing: Icon(IconsaxPlusLinear.arrow_right_3), // Add icon to the right side
      onTap: () {
        isUserLoggedIn
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostHazardPage(
                    postHazardUseCase: PostHazardUseCase(
                      repository: HazardDI.repository,
                      userLocalDataSource: UserDI.localDataSource,
                    ),
                    fetchUserInfoUseCase: UserDI.fetchUserInfoUseCase,
                    hazardTypeId: hazardType.id,
                    hazardTypeName: hazardType.nameMn,
                  ),
                ),
              )
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserInfoPage(
                    fetchUserInfoUseCase: UserDI.fetchUserInfoUseCase,
                    saveUserInfoFromInputUseCase: UserDI.saveUserInfoFromInput,
                    clearUserInfoCacheUseCase: UserDI.clearUserInfoCacheUsecase,
                    hazardTypeId: hazardType.id,
                    hazardTypeName: hazardType.nameMn,
                  ),
                ),
              );
      },
    );
  }
}