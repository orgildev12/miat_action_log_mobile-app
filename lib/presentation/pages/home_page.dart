import 'package:action_log_app/application/use_cases/hazard_type_use_cases/fetch_hazard_types_use_case.dart';
import 'package:action_log_app/core/di/features/hazard_di.dart';
import 'package:action_log_app/core/di/features/hazard_type_di.dart';
import 'package:action_log_app/domain/entities/hazard_type.dart';
import 'package:action_log_app/presentation/components/app_bar.dart';
import 'package:action_log_app/presentation/components/hazard_type_selector.dart';
import 'package:action_log_app/presentation/components/home_big_button.dart';
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
  List<HazardType> hazardTypes = [];
  Future <void> _fetchHazardTypes () async {
    try {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ActionLogAppBar(isLoggedIn: widget.isUserLoggedIn),
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
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
                            ? 'МИАТ ХК нь нислэгийн аюулгүй ажиллагаа, чанар, нисэхийн аюулгүй байдалтай холбоотой аюул, эрсдэлийг цаг тухайд нь нээлттэй мэдээллэхийг дэмжих зорилгоор шийтгэлгүй мэдээллийн тогтолцоог хэрэгжүүлэн ажилладаг. Mэдээллийн дагуу бид зөрчил дутагдалд дүн шинжилгээ хийх, эрсдэлийг бууруулах, засч залруулах болон цаашид давтагдахаас урьдчилан сэргийлэх арга хэмжээ авч ажиллах ба нууцлалтай мэдээлэл ирүүлсэн тохиолдолд мэдээлэгчийн нууцлалыг чадндлан хадгална. Аюулгүй ажиллагааны мэдээлэл ирүүлж нислэгийн аюулгүй ажиллагааг сайжруулахад хувь нэмэр оруулж буй танд баярлалаа.'
                            : 'МИАТ ХК нь нислэгийн аюулгүй ажиллагаа, чанар, нисэхийн аюулгүй байдалтай холбоотой аюул, эрсдэлийг цаг тухайд нь нээлттэй мэдээллэхийг дэмжих зорилгоор шийтгэлгүй мэдээллийн тогтолцоог хэрэгжүүлэн ажилладаг...',
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
                isColored: true, buttonText: 'Мэдээлэл өгөх', buttonIcon: IconsaxPlusLinear.message, 
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: hazardTypes.map((hazardType) => 
                            HazardTypeSelector(hazardType: hazardType, isUserLoggedIn: widget.isUserLoggedIn)
                          ).toList(),
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 12),
              HomeBigButton(isColored: false, buttonText: 'Нэрээ нууцлаж мэдээллэх', buttonIcon: IconsaxPlusLinear.shield),
              SizedBox(height: 12),
              HomeBigButton(isColored: false, buttonText: 'Бусад сувгууд', buttonIcon: IconsaxPlusLinear.arrow_right_3, otherRecources: true),
            ],
          ),
        ),
      ),
    );
  }
}