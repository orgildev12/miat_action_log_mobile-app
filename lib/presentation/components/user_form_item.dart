import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';

class UserFormItem extends StatefulWidget {
  final String labelText;
  final IconData iconData;
  final Function(String) onValueChanged;
  final String formValue;
  final bool isPassword; // New optional parameter
  final TextInputType keyboardType; // New optional parameter

  const UserFormItem({
    super.key,
    required this.labelText,
    required this.iconData,
    required this.onValueChanged,
    required this.formValue,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<UserFormItem> createState() => _UserFormItemState();
}

class _UserFormItemState extends State<UserFormItem> {
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
  void didUpdateWidget(covariant UserFormItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.formValue != widget.formValue && _controller.text != widget.formValue) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _controller.text = widget.formValue;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword, // Use the isPassword flag to obscure text
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: black,
          ),
        ),
        prefixIcon: Icon(widget.iconData, color: black),
      ),
      cursorColor: black,
      onChanged: widget.onValueChanged,
      validator: (val) => val == null || val.isEmpty ? null : null, // Not required
    );
  }
}
