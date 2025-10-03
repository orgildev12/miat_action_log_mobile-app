import 'package:flutter/material.dart';

class HazartDetailsItem extends StatelessWidget {
  final String text1;
  final String text2;

  const HazartDetailsItem({
    super.key,
    required this.text1,
    required this.text2,
    });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text1, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
        Text(text2, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
      ],
    );
  }
}