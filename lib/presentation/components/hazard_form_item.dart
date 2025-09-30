import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';

class HazardFormItem extends StatefulWidget {
  final String hintText;
  final String labelText;
  final Function(String) onValueChanged;
  final String formValue;

  const HazardFormItem({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.onValueChanged,
    required this.formValue,
  });

  @override
  State<HazardFormItem> createState() => _HazardFormItemState();
}

class _HazardFormItemState extends State<HazardFormItem> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.formValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: black)),
        SizedBox(height: 12),
        TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: hintText,
              fontSize: 14,
            ),
            labelStyle: TextStyle(
              color: black,
              fontWeight: FontWeight.w500,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: primaryColor,
              ),
            ),
            filled: true,
            fillColor: white,
          ),
          cursorColor: black,
          onChanged: widget.onValueChanged,
          validator: (val) => val == null || val.isEmpty ? null : null,
          minLines: 1,
          maxLines: null,
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
