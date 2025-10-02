import 'package:action_log_app/presentation/components/info_panel.dart';
import 'package:action_log_app/presentation/components/small_login_button.dart';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class SecretHazardPageForTempUser extends StatelessWidget {
  const SecretHazardPageForTempUser({super.key});

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                          SizedBox(height: 32),
              Text('Нэрээ нууцлаж мэдээллэх маягт',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              SizedBox(height: 16),
              Text(
                'Нэрээ нууцлаж илгээсэн тохиолдолд таны хувийн мэдээлэл зөвхөн онцгой эрхтэй албан тушаалтанд харагдах болно.',
                style: TextStyle(
                  color: black,
                  fontSize: 14,
                )
              ),
              SizedBox(height: 32),
              InfoPanel(heading: 'Санамж', content: 'Энэхүү тусгай маягтыг зөвхөн дотоод ажилтнууд илгээх боломжтой бөгөөд хэрвээ та ажилтан бол нэвтэрсэн байх шаардлагатай.'),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SmallLoginButton(),
                ],
              )
          ],
          ),
        
        )
    );
  }
}