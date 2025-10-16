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

  late String username;
  late String email;
  late String phoneNumber;

  bool isSelectedLocationGroup = false;
  int? selectedLocationGroupId;
  
  @override
  void initState() {
    super.initState();
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
          title: title ?? 'Уучлаарай',
          content: description ?? 'Алдаа гарлаа. Дахин оролдоно уу',
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
        firstLocationFormValue = selectedLocation.nameMn;
        locationId = selectedLocation.id;
      });
    }else{
      setState(() {
        firstLocationFormValue = '';
        secondLocationFormValue = '';
        locationId = null;
        firstLocationFormValue = selectedLocation.groupNameMn!;
        selectedLocationGroupId = selectedLocation.locationGroupId;
        selectedLocationGroupName = selectedLocation.groupNameMn!;
        isSelectedLocationGroup = true;
      });
    }
  }


  void _setSecondLocationFormValue(Location selectedLocation) {
      setState(() {
        secondLocationFormValue = selectedLocation.nameMn;
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
        bool isUserIdHere = user.id != null;
        if(result == true){
          _openSuccessDialog(context, 'Таны мэдээлэл амжилттай илгээгдлээ. Баярлалаа!');
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
              Text(widget.hazardTypeName.toString(),
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
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    HazardDropDownForm(
                      hintText: 'Байршил сонгох',
                      labelText: 'Байршил',
                      formValue: firstLocationFormValue,
                      dropDownItems: [
                        ...locations
                            .where((location) => location.locationGroupId == null)
                            .map((location) => {
                                  'label': location.nameMn,
                                  'isGroup': false,
                                })
                            ,

                        ...locations
                            .where((location) => location.locationGroupId != null)
                            .map((location) => location.groupNameMn ?? '')
                            .toSet() // deduplicate group names
                            .map((groupName) => {
                                  'label': groupName,
                                  'isGroup': true,
                                })
                            ,
                      ],
                      onValueChanged: (val) {
                        final selectedLocation = locations.firstWhere(
                          (location) => location.nameMn == val || location.groupNameMn == val,
                          orElse: () => Location(
                            id: -1,
                            nameMn: val,
                            nameEn: val,
                          ),
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
                            hintText: '$selectedLocationGroupName сонгох',
                            formValue: locationId != null
                                ? (locations.firstWhere(
                                    (location) => location.id == locationId,
                                    orElse: () => Location(
                                      id: -1,
                                      nameMn: '',
                                      nameEn: '',
                                    ),
                                  ).nameMn)
                                : '',

                            dropDownItems: locations
                                .where((location) => location.locationGroupId == selectedLocationGroupId)
                                .map((location) => {
                                      'label': location.nameMn,
                                      'isGroup': false,
                                    })
                                .toList(),

                            onValueChanged: (val) {
                              final selectedLocation = locations.firstWhere(
                                (location) => location.nameMn == val,
                                orElse: () => Location(
                                  id: -1,
                                  nameMn: val,
                                  nameEn: val,
                                ),
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
                    labelText: 'Дэлгэрэнгүй мэдээлэл',
                    hintText: 'Аюул, зөрчил эсвэл алдааны талаар дэлгэрэнгүй тайлбарлана уу.',
                    formValue: description,
                    onValueChanged: (val) => setState(() {
                      description = val;
                    }),
                    validator: (val) {
                      if (val == null || val.trim().length < 10) {
                        return 'Мэдээлэл хэт богино байна';
                      }
                      return null;
                    },
                  ),
                    SizedBox(height: 28),
                    HazardFormItem(
                      labelText: 'Эрсдэлийг бууруулах, арилгах талаар санал',
                      hintText: 'Ийм алдаа дахин давтагдахаас сэргийлж юу хийж болох талаар саналаа бичнэ үү.',
                      formValue: solution,
                      onValueChanged: (val) => setState(() {
                        solution = val;
                      }),
                      validator: (val) {
                      if (val == null || val.trim().length < 10) {
                        return 'Мэдээлэл хэт богино байна';
                      }
                      return null;
                    },
                    ),
                  ],
                )),
              SizedBox(height: 28),
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
              SizedBox(height: 64),
              BigButton(buttonText: 'Илгээх', isActive: isActive, onTap: _submitHazard, iconData: IconsaxPlusLinear.send_2),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
