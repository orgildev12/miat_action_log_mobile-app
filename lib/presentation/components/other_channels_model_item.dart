import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class OtherChannelsModelItem extends StatefulWidget {
  final String text1;
  final String text2;
  final IconData icon;
  const OtherChannelsModelItem({
    super.key,
    required this.text1,
    required this.text2,
    required this.icon
  });

  @override
  State<OtherChannelsModelItem> createState() => _OtherChannelsModelItemState();
}

class _OtherChannelsModelItemState extends State<OtherChannelsModelItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(widget.icon, size: 22, color: primaryColor,),
                SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.text1,
                      style: TextStyle(
                        color: black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),
                      
                      ),
                    // SizedBox(height: 4,),
                    Text(
                      widget.text2,
                      style: TextStyle(
                        color: black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),
                      
                      ),
                  ],
                ),
              ],
            ),
        
            Icon(IconsaxPlusLinear.arrow_right_3, size: 22,)
          ],
        ),
        SizedBox(height: 12)
      ],
    );
  }
}