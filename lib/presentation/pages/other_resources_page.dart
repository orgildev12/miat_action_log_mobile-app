import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class OtherChannelsPage extends StatelessWidget {
  const OtherChannelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(IconsaxPlusLinear.arrow_left_1, color: black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Бусад сувгууд',
          style: TextStyle(
            color: black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Сайн дурын мэдээлэл өгөх сувгууд',
                style: TextStyle(
                    color: black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: primaryColor,
                    )
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Icon(
                  IconsaxPlusLinear.call, 
                  color: black,
                  size: 20.0,
                  
                  ),
                SizedBox(width: 16),
                Text('+976 11284038',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        decorationColor: primaryColor,
                        )
                ),
                Text(',   ',
                    style: TextStyle(
                        color: black,
                        fontSize: 16,
                        )
                ),
                Text('+976 11284103',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        decorationColor: primaryColor,
                        )
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  IconsaxPlusLinear.sms, 
                  color: black,
                  size: 20.0,
                  ),
                SizedBox(width: 16),
                Text('aachnaba@miat.com',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        decorationColor: primaryColor,
                        ),
                    
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  IconsaxPlusLinear.global, 
                  color: black,
                  size: 20.0,
                  ),
                SizedBox(width: 16),
                Text('https://daraa_ni_neg_ym_bichne.com',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        decorationColor: primaryColor,
                        )
                ),
              ],
            ),
            SizedBox(height: 56),
            Text('Нууцлалтай мэдээлэл өгөх сувгууд',
                style: TextStyle(
                    color: black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)
            ),
SizedBox(height: 24),
            Row(
              children: [
                Icon(
                  IconsaxPlusLinear.call, 
                  color: black,
                  size: 20.0,
                  
                  ),
                SizedBox(width: 16),
                Text('+976 11284049',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        decorationColor: primaryColor,
                        )
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  IconsaxPlusLinear.sms, 
                  color: black,
                  size: 20.0,
                  ),
                SizedBox(width: 16),
                Text('tsogtgerel_d@miat.com',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        decorationColor: primaryColor,
                        ),
                    
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  IconsaxPlusLinear.global, 
                  color: black,
                  size: 20.0,
                  ),
                SizedBox(width: 16),
                Text('https://daraa_ni_neg_ym_bichne.com',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        decorationColor: primaryColor,
                        )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}