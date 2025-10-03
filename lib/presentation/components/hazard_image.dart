import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';

class HazardImage extends StatefulWidget {
  const HazardImage({super.key});

  @override
  State<HazardImage> createState() => _HazardImageState();
}

class _HazardImageState extends State<HazardImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey),
              ),
              child: Center(
                child: Text(
                  'Зураг',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(
              width: 180,
              child: Text(
                'zuragnii_mash_urt_ner_end_bgaa_geh_bodyo.png',
                style: TextStyle(
                  fontSize: 16,
                  // fontWeight: FontWeight.bold,
                  color: black,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}