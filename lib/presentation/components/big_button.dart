import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';

class BigButton extends StatefulWidget {
  final String buttonText;
  final bool isActive;
  final VoidCallback? onTap;
  final IconData? iconData;

  const BigButton({
    super.key,
    required this.buttonText,
    required this.isActive,
    this.onTap,
    this.iconData
    });

  @override
  State<BigButton> createState() => _BigButtonState();
}

class _BigButtonState extends State<BigButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 0),
      child: InkWell(
        onTap: widget.isActive ? widget.onTap : (){},
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: widget.isActive ? mainGradient : null,
            color: widget.isActive ? null : Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(18),
            boxShadow: widget.isActive
                ? [
                    BoxShadow(
                      color: Color(0xFF292D32).withOpacity(0.15),
                      spreadRadius: 0,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                    BoxShadow(
                      color: Color(0xFF292D32).withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 25,
                      offset: Offset(4, 4),
                    ),
                  ]
                : [],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.buttonText,
                  style: TextStyle(
                    color: widget.isActive ?Color(0xFFF5F5F5) : black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (widget.iconData != null) ...[
                  SizedBox(width: 8),
                  Icon(widget.iconData, color: widget.isActive ? Color(0xFFF5F5F5) : black, size: 24),
                ],
                ]
              ),
          ),
        ),
      ),
    );
  }
}