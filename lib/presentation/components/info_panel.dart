import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';

class InfoPanel extends StatelessWidget {
  final String heading;
  final String content;

  const InfoPanel({
    super.key,
    this.heading = '',
    required this.content,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: primaryColor)

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (heading.isNotEmpty) ...[
            Text(
              heading,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: black
              ),
            ),
            SizedBox(height: 4),
          ],
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: black
            ),
          ),
        ],
      ),
    );
  }
}