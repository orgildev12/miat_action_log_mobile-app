import 'package:action_log_app/domain/entities/hazard.dart';
import 'package:action_log_app/presentation/pages/hazard_details_page.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class HazardListItem extends StatefulWidget {
  final Hazard hazard;
  const HazardListItem({
    super.key,
    required this.hazard
    });

  @override
  State<HazardListItem> createState() => _HazardListItemState();
}

class _HazardListItemState extends State<HazardListItem> {

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _pushToDetails(BuildContext context) async {
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => (HazardDetailsPage(hazard: widget.hazard)),
        ),
      );
    }
    return Column(
      children: [
        InkWell(
          onTap: () => _pushToDetails(context),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          widget.hazard.isPrivate == 0 ? Icon(IconsaxPlusLinear.message, color: black, size: 24) : Icon(IconsaxPlusLinear.security_user, color: black, size: 24),
                          SizedBox(width: 8),
                          Container(
                            width: 2,
                            height: 24,
                            decoration: BoxDecoration(
                              color: black,
                              borderRadius: BorderRadius.circular(1),
                            )
                          ),
                          SizedBox(width: 8),
                          SizedBox(
                            width: 144,
                            child: Text(
                              Localizations.localeOf(context).languageCode == 'mn' ? widget.hazard.typeNameMn.toString() : widget.hazard.typeNameEn.toString(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: black,
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                      Row(
                        children: [
                           Text(
                              Localizations.localeOf(context).languageCode == 'mn' ? widget.hazard.statusMn : widget.hazard.statusEn,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: black,
                              ),),
                          SizedBox(width: 8),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: widget.hazard.statusMn == "Шийдэгдсэн" ?  Colors.green :
                                     widget.hazard.statusMn == "Ажиллаж байна" ? Colors.orange :
                                     widget.hazard.statusMn == "Татгалзсан" ? Colors.red :
                                     Colors.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 40,
                    child: Text(
                      widget.hazard.description,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  
                ],
              ),
              
              
              ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}