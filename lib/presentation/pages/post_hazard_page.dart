import 'package:action_log_app/application/use_cases/hazard_use_cases/post_hazard_use_case.dart';
import 'package:action_log_app/application/use_cases/location_use_cases/clear_location_cache.dart';
import 'package:action_log_app/application/use_cases/location_use_cases/fetch_locations_use_case.dart';
import 'package:action_log_app/application/use_cases/user_use_cases/fetch_user_info_use_case.dart';
import 'package:action_log_app/core/di/features/location_di.dart';
import 'package:action_log_app/core/error/exceptions.dart';
import 'package:action_log_app/domain/entities/location.dart';
import 'package:action_log_app/domain/entities/user.dart';
import 'package:action_log_app/l10n/app_localizations.dart';
import 'package:action_log_app/models/post_hazard_model.dart';
import 'package:action_log_app/presentation/components/add_image_button.dart';
import 'package:action_log_app/presentation/components/big_button.dart';
import 'package:action_log_app/presentation/components/hazard_drop_down_form.dart';
import 'package:action_log_app/presentation/components/hazard_form_item.dart';
import 'package:action_log_app/presentation/components/pop_up.dart';
import 'package:action_log_app/presentation/pages/main_navigator.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class PostHazardPage extends StatefulWidget {
  final PostHazardUseCase postHazardUseCase;
  final FetchUserInfoUseCase fetchUserInfoUseCase;
  final int hazardTypeId;
  final String hazardTypeName;

  const PostHazardPage({
    super.key,
    required this.postHazardUseCase,
    required this.fetchUserInfoUseCase,
    required this.hazardTypeId,
    required this.hazardTypeName,
  });

  @override
  State<PostHazardPage> createState() => _PostHazardPageState();
}

class _PostHazardPageState extends State<PostHazardPage> {
  User user = User();
  FetchLocationsUseCase fetchLocationUseCase = LocationDI.fetchLocationsUseCase;
  ClearLocationCacheUseCase clearLocationCacheUseCase = LocationDI.clearLocationCacheUseCase;
  List<Location> locations = [];
  final _formKey = GlobalKey<FormState>();
  int? typeId;
  int? locationId;
  String description = '';
  String solution = '';
  String firstLocationFormValue = '';
  String secondLocationFormValue = '';
  String selectedLocationGroupName = '';

  String? languageCode = 'mn';

  late String username;
  late String email;
  late String phoneNumber;

  bool isSelectedLocationGroup = false;
  int? selectedLocationGroupId;
  
  @override
  void initState() {
    super.initState();
    final currentLocale = Get.locale;
    languageCode = currentLocale?.languageCode ?? 'mn';
    _loadUserInfo();
    _fetchLocations();
  }


  Future<void> _loadUserInfo() async {
    try {
      final fetchedUser = await widget.fetchUserInfoUseCase.call();
      setState(() {
        user = fetchedUser;
      });
    } catch (e) {
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load user info: $e')),
      );
    }
  }


  void _openSuccessDialog(BuildContext context, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopUp(
          icon: IconsaxPlusLinear.tick_circle,
          colorTheme: 'success',
          title: AppLocalizations.of(context)!.success,
          content: description,
          onPress: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => MainNavigator(),
              ),
              (route) => false,
            );
          },
        );
      },
    );
  }


  Future<void> _openErrorDialog(
    BuildContext context, {
    int? statusCode,
    String? dialogTitle,
    String? dialogDescription,
  }) {
    String? title = dialogTitle;
    String? description = dialogDescription;

    if (statusCode != null) {
      switch (statusCode) {
        case 401:
          title = AppLocalizations.of(context)!.warning;
          description = AppLocalizations.of(context)!.description500;
          break;
        case 503:
          title = AppLocalizations.of(context)!.weAreSorry;
          description = AppLocalizations.of(context)!.description503;
          break;
        default:
          title = AppLocalizations.of(context)!.sorry;
          description = AppLocalizations.of(context)!.description500;;
      }
    }

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopUp(
          icon: IconsaxPlusLinear.close_circle,
          colorTheme: 'danger',
          title: title ?? AppLocalizations.of(context)!.sorry,
          content: description ?? AppLocalizations.of(context)!.description500,
          onPress: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }


  Future<void> _fetchLocations() async {
    try {
      // await clearLocationCacheUseCase.call();
      final result = await fetchLocationUseCase.call(
        includeLocationsWithLGroup: true,
      );
      setState(() {
        locations = result;
      });

    } on ServerException catch (e) {
        _openErrorDialog(context, statusCode: e.statusCode);
    } catch (e) {
      _openErrorDialog(context);
    }
  }


  void _setFirstLocationFormValue(Location selectedLocation) {
    if(selectedLocation.locationGroupId == null){
      setState(() {
        isSelectedLocationGroup = false;
        firstLocationFormValue = '';
        secondLocationFormValue = '';
        selectedLocationGroupId = null;
        languageCode == 'mn'
          ? firstLocationFormValue = selectedLocation.nameMn
          : firstLocationFormValue = selectedLocation.nameEn;
        locationId = selectedLocation.id;
      });
    }else{
      setState(() {
        firstLocationFormValue = '';
        secondLocationFormValue = '';
        locationId = null;
        languageCode == 'mn'
          ? firstLocationFormValue = selectedLocation.groupNameMn!
          : firstLocationFormValue = selectedLocation.groupNameEn!;
        selectedLocationGroupId = selectedLocation.locationGroupId;
        languageCode == 'mn' 
          ? selectedLocationGroupName = selectedLocation.groupNameMn!
          : selectedLocationGroupName = selectedLocation.groupNameEn!;
        isSelectedLocationGroup = true;
      });
    }
  }


  void _setSecondLocationFormValue(Location selectedLocation) {
      setState(() {
        languageCode == 'mn'
        ? secondLocationFormValue = selectedLocation.nameMn
        : secondLocationFormValue = selectedLocation.nameEn;
        locationId = selectedLocation.id;
      });
  }
  
  void _submitHazard() async {
    if (_formKey.currentState!.validate()) {
      try{
        final hazardModel = PostHazardModel(
          userId: user.id,
          userName: user.username,
          email: user.email,
          phoneNumber: user.phoneNumber,
          typeId: widget.hazardTypeId,
          locationId: locationId!,
          description: description,
          solution: solution,
        );

        final result = await widget.postHazardUseCase.call(hazardModel, isUserLoggedIn: user.id != null);
        if(result == true){
          _openSuccessDialog(context, AppLocalizations.of(context)!.sentSuccessfully);
        }
      } on ServerException catch (e) {
        
        _openErrorDialog(context, statusCode: e.statusCode);
      } catch (e) {
        _openErrorDialog(context);
      }
    }
  }

  bool get isActive => locationId != null && description.trim().isNotEmpty && solution.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(IconsaxPlusLinear.arrow_left_1, color: black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          AppLocalizations.of(context)!.reportHazard,
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
              Text(widget.hazardTypeName.toString(),
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.weWillUseThisForOnly,
                style: TextStyle(
                  color: black,
                  fontSize: 14,
                )
              ),
              SizedBox(height: 32),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    HazardDropDownForm(
                      hintText: AppLocalizations.of(context)!.selectLocation,
                      labelText: AppLocalizations.of(context)!.location,
                      formValue: firstLocationFormValue,
                      dropDownItems: [
                        ...locations
                            .where((location) => location.locationGroupId == null)
                            .map((location) => {
                                  'label': languageCode == 'mn' ? location.nameMn : location.nameEn,
                                  'isGroup': false,
                                })
                            ,

                        ...locations
                            .where((location) => location.locationGroupId != null)
                            .map((location) => languageCode == 'mn' ? location.groupNameMn ?? '' : location.groupNameEn ?? '')
                            .toSet() // deduplicate group names
                            .map((groupName) => {
                                  'label': groupName,
                                  'isGroup': true,
                                })
                            ,
                      ],
                      onValueChanged: (val) {
                        final selectedLocation = locations.firstWhere(
                          (location) {
                            if (languageCode == 'mn') {
                              return location.nameMn == val || (location.groupNameMn != null && location.groupNameMn == val);
                            } else {
                              return location.nameEn == val || (location.groupNameEn != null && location.groupNameEn == val);
                            }
                          },
                          orElse: () => Location(id: -1, nameMn: val, nameEn: val),
                        );

                        if (selectedLocation.id != -1) {
                          _setFirstLocationFormValue(selectedLocation);
                        } else {
                          debugPrint("Location not found for value: $val");
                        }
                      },
                    ),
                  
                    if(isSelectedLocationGroup)
                      Column(
                        children: [
                          SizedBox(height: 8),
                          HazardDropDownForm(
                            hintText: languageCode == 'mn' ? '$selectedLocationGroupName сонгох' : 'Select $selectedLocationGroupName',
                            formValue: locationId != null
                              ? (languageCode == 'mn'
                                  ? locations.firstWhere((location) => location.id == locationId).nameMn
                                  : locations.firstWhere((location) => location.id == locationId).nameEn)
                              : '',

                            dropDownItems: locations
                                .where((location) => location.locationGroupId == selectedLocationGroupId)
                                .map((location) => {
                                      'label': languageCode == 'mn' ? location.nameMn : location.nameEn,
                                      'isGroup': false,
                                    })
                                .toList(),

                            onValueChanged: (val) {
                              final selectedLocation = locations.firstWhere(
                                (location) =>
                                    location.locationGroupId == selectedLocationGroupId && // filter by group
                                    (languageCode == 'mn' ? location.nameMn == val : location.nameEn == val), // language check
                                orElse: () => Location(id: -1, nameMn: val, nameEn: val),
                              );

                              if (selectedLocation.id != -1) {
                                _setSecondLocationFormValue(selectedLocation);
                              } else {
                                debugPrint("Location not found for value: $val");
                              }
                            },
                          )
                          ]
                      ),
                    SizedBox(height: 28),
                    HazardFormItem(
                    labelText: AppLocalizations.of(context)!.hazardDetails,
                    hintText: AppLocalizations.of(context)!.hazardDescription,
                    formValue: description,
                    onValueChanged: (val) => setState(() {
                      description = val;
                    }),
                    validator: (val) {
                      if (val == null || val.trim().length < 10) {
                        return AppLocalizations.of(context)!.tooShort;
                      }
                      return null;
                    },
                  ),
                    SizedBox(height: 28),
                    HazardFormItem(
                      labelText: AppLocalizations.of(context)!.suggession,
                      hintText: AppLocalizations.of(context)!.suggessionLong,
                      formValue: solution,
                      onValueChanged: (val) => setState(() {
                        solution = val;
                      }),
                      validator: (val) {
                      if (val == null || val.trim().length < 10) {
                        return AppLocalizations.of(context)!.tooShort;
                      }
                      return null;
                    },
                    ),
                  ],
                )),
              SizedBox(height: 28),
              Text(AppLocalizations.of(context)!.image, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: black)),
              SizedBox(height: 12),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: AddImageButton(
                      buttonText: AppLocalizations.of(context)!.takePicture, 
                      iconData: IconsaxPlusLinear.camera,)
                  ),
                  SizedBox(width: 16),
                  Flexible(
                    flex: 1,
                    child: AddImageButton(
                      buttonText: AppLocalizations.of(context)!.attachzPicture, 
                      iconData: IconsaxPlusLinear.paperclip_2,)
                  ),

                ],
              ),
              SizedBox(height: 64),
              BigButton(buttonText: AppLocalizations.of(context)!.send, isActive: isActive, onTap: _submitHazard, iconData: IconsaxPlusLinear.send_2),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
