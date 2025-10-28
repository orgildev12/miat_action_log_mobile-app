import 'package:action_log_app/application/use_cases/hazard_type_use_cases/clear_hazard_type_cache_use_case.dart';
import 'package:action_log_app/application/use_cases/hazard_type_use_cases/fetch_hazard_types_use_case.dart';
import 'package:action_log_app/application/use_cases/hazard_use_cases/post_hazard_use_case.dart';
import 'package:action_log_app/core/di/features/hazard_di.dart';
import 'package:action_log_app/core/di/features/hazard_type_di.dart';
import 'package:action_log_app/core/di/features/user_di.dart';
import 'package:action_log_app/domain/entities/hazard_type.dart';
import 'package:action_log_app/l10n/app_localizations.dart';
import 'package:action_log_app/presentation/components/hazard_type_selector.dart';
import 'package:action_log_app/presentation/components/home_big_button.dart';
import 'package:action_log_app/presentation/components/other_channels_model_item.dart';
import 'package:action_log_app/presentation/pages/post_hazard_page.dart';
import 'package:action_log_app/presentation/pages/secret_hazard_page_for_temp_user.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class HomePage extends StatefulWidget {
  final bool isUserLoggedIn;
  const HomePage({
    super.key,
    required this.isUserLoggedIn,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isExpanded = false;

  FetchHazardTypesUseCase fetchHazardTypesUseCase = HazardTypeDI.fetchHazardTypesUseCase;
  ClearHazardTypeCacheUseCase clearHazardTypeUseCase = HazardTypeDI.clearHazardTypeCacheUseCase;
  List<HazardType> hazardTypes = [];
  Future <void> _fetchHazardTypes () async {
    try {
      // await clearHazardTypeUseCase.call();
      final result = await fetchHazardTypesUseCase.call();
      setState(() {
        hazardTypes = result;
      });
    } catch (e) {
      print('Error fetching hazard types: $e');
    }
  }

 

  @override
  void initState() {
    super.initState();
    _fetchHazardTypes();
    // bool isUserlogogo = widget.isUserLoggedIn;
    // print('homepage is thinking isUserLoggedIn: $isUserlogogo');
  }

  void _handleHazardButtonTap({required bool isPrivate}) {
    if (isPrivate && !widget.isUserLoggedIn) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SecretHazardPageForTempUser(),
        ),
      );
      return;
    }

    final filteredHazardTypes = hazardTypes
        .where((hazardType) => hazardType.isPrivate == (isPrivate ? 1 : 0))
        .toList();

    if (filteredHazardTypes.length == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PostHazardPage(
            postHazardUseCase: PostHazardUseCase(
              repository: HazardDI.repository,
              userLocalDataSource: UserDI.localDataSource,
            ),
            fetchUserInfoUseCase: UserDI.fetchUserInfoUseCase,
            hazardTypeId: filteredHazardTypes.first.id,
            hazardTypeName: filteredHazardTypes.first.nameMn,
          ),
        ),
      );
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              shrinkWrap: true, 
              children: filteredHazardTypes
                  .map((hazardType) => HazardTypeSelector(
                        hazardType: hazardType,
                        isUserLoggedIn: widget.isUserLoggedIn,
                      ))
                  .toList(),
            ),
          );
        },
      );

    }
  }

void showOtherChannels() {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: backgroundColor,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal:  16, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.hazardReportChannels,
              style: TextStyle(
                color: black,
                fontSize: 16,
                fontWeight: FontWeight.w800
              ),
            ),
            SizedBox(height: 8,),
            Container(
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(16)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OtherChannelsModelItem(text1:  AppLocalizations.of(context)!.infomationCenter, text2: '+976 11284028', icon: IconsaxPlusLinear.call),
                    OtherChannelsModelItem(text1: AppLocalizations.of(context)!.email, text2: 'aachnaba@miat.com', icon: IconsaxPlusLinear.sms),
                    OtherChannelsModelItem(text1: AppLocalizations.of(context)!.web, text2: 'www.example.com', icon: IconsaxPlusLinear.global),
                  ],
                ),
              ),
            ),
            SizedBox(height: 36,),
            Text(
              AppLocalizations.of(context)!.confidentialReportChannels,
              style: TextStyle(
                color: black,
                fontSize: 16,
                fontWeight: FontWeight.w800
              ),
            ),
            SizedBox(height: 8,),
            Container(
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(16)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OtherChannelsModelItem(text1: AppLocalizations.of(context)!.infomationCenter, text2: '+976 11284049', icon: IconsaxPlusLinear.call),
                    OtherChannelsModelItem(text1: AppLocalizations.of(context)!.email, text2: 'tsogtgerel_d@miat.com', icon: IconsaxPlusLinear.sms),
                    OtherChannelsModelItem(text1: AppLocalizations.of(context)!.web, text2: 'www.example.com', icon: IconsaxPlusLinear.global),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 24,
            )
          ],
        ),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 32),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'lib/presentation/assets/images/action_log_banner.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 14, color: black),
                    children: [
                      TextSpan(
                        text: isExpanded
                            ? AppLocalizations.of(context)!.homeDescriptionMore
                            : AppLocalizations.of(context)!.homeDescriptionLess,
                      ),
                      TextSpan(
                        text: isExpanded ? ' Less' : ' More',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              isExpanded = !isExpanded; // Toggle expansion
                            });
                          },
                      ),
                    ],
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(height: 40),
              HomeBigButton(
                isColored: true, buttonText: AppLocalizations.of(context)!.reportHazard, buttonIcon: IconsaxPlusLinear.message, 
                onTap: () => _handleHazardButtonTap(isPrivate: false),
              ),
              SizedBox(height: 12),
              HomeBigButton(
                isColored: false, 
                buttonText: AppLocalizations.of(context)!.confidentialHazardReport, 
                buttonIcon: IconsaxPlusLinear.shield,
                onTap: () => _handleHazardButtonTap(isPrivate: true),
              ),
              SizedBox(height: 12),
              HomeBigButton(
                isColored: false, 
                buttonText: AppLocalizations.of(context)!.otherChannels, 
                buttonIcon: IconsaxPlusLinear.arrow_right_3, 
                otherRecources: true,
                onTap: showOtherChannels,
                // onTap: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => OtherChannelsPage()
                //     )
                //   );
                // },
                
                ),
                SizedBox(height: 64),
            ],
          ),
        );
      
  }
}