import 'dart:io';
import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';

class HazardImage extends StatefulWidget {
  final File imageFile;
  final VoidCallback onLongPress;
  const HazardImage({
    super.key, 
    required this.imageFile,
    required this.onLongPress
    });

  @override
  State<HazardImage> createState() => _HazardImageState();
}

class _HazardImageState extends State<HazardImage> {
  bool isPressed = false;

  void _handleLongPressStart(_) async {
    setState(() => isPressed = true);
    await Future.delayed(const Duration(milliseconds: 300));
    widget.onLongPress();
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => isPressed = false);
  }

  void _handleLongPressEnd(_) {
    setState(() => isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onLongPressStart: _handleLongPressStart,
        onLongPressEnd: _handleLongPressEnd,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isPressed
                ? [
                    BoxShadow(
                      color: const Color.fromARGB(80, 41, 45, 50),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    )
                  ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: FileImage(widget.imageFile),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: Text(
                    widget.imageFile.path.split('/').last,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 16,
                      color: black,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
