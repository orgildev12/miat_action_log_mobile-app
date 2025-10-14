import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';

class HazardFormItem extends StatefulWidget {
  final String hintText;
  final String labelText;
  final Function(String) onValueChanged;
  final String formValue;
  final FormFieldValidator<String>? validator;

  const HazardFormItem({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.onValueChanged,
    required this.formValue,
    this.validator,
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
        Text(
          widget.labelText,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: black,
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _controller,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: hintText,
            fontSize: 14,
          ),
          labelStyle: const TextStyle(
            color: black,
            fontWeight: FontWeight.w500,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: primaryColor),
          ),
          errorBorder: OutlineInputBorder( // 🔥 add this
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: danger),
          ),
          focusedErrorBorder: OutlineInputBorder( // 🔥 add this too
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: danger, width: 1.5),
          ),
          filled: true,
          fillColor: white,
        ),
          cursorColor: black,
          onChanged: widget.onValueChanged,
          validator: widget.validator,
          minLines: 1,
          maxLines: null,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
