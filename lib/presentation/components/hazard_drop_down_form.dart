import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class HazardDropDownForm extends StatelessWidget {
  final String hintText;
  final String labelText;
  final Function(String) onValueChanged;
  final String formValue;
  final List<Map<String, dynamic>> dropDownItems; // include 'isGroup'

  const HazardDropDownForm({
    super.key,
    required this.hintText,
    this.labelText = '',
    required this.onValueChanged,
    required this.formValue,
    required this.dropDownItems,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                labelText,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: black,
                ),
              ),
              SizedBox(height: 12),
            ],
          ),
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 60),
          child: Material(
            color: Colors.transparent,
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                value: formValue.isNotEmpty ? formValue : null,
                isExpanded: true,
                borderRadius: BorderRadius.circular(20),
                menuMaxHeight: 300,
                dropdownColor: Colors.white,
                items: dropDownItems.map((item) {
                  final isGroup = item['isGroup'] as bool? ?? false;
                  final label = item['label'] as String? ?? '';
                  return DropdownMenuItem<String>(
                    value: label,
                    child: Row(
                      children: [
                        Icon(
                          isGroup
                              ? IconsaxPlusLinear.routing
                              : IconsaxPlusLinear.location,
                          size: 16,
                          color: black,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            label,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) onValueChanged(val);
                },
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: primaryColor),
                  ),
                  filled: true,
                  fillColor: white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
