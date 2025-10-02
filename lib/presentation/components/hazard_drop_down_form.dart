import 'package:action_log_app/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class HazardDropDownForm extends StatelessWidget {
  final String hintText;
  final String labelText;
  final Function(String) onValueChanged;
  final String formValue;
  final List<Map<String, dynamic>> dropDownItems; // Updated to include metadata

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
          if(labelText.isNotEmpty) // Only show label if it's not empty
        Column(
          children: [
            Text(labelText, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: black)),
            SizedBox(height: 12),
          ],
        ),
        // Wrap DropdownButtonFormField in a ConstrainedBox to ensure proper dropdown placement
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 60), // Ensure dropdown field height is constrained
          child: Material(
            color: Colors.transparent,
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                initialValue: formValue.isNotEmpty ? formValue : null, // <-- null shows hint
                isExpanded: true,
                menuMaxHeight: 300, // Ensure dropdown menu height is limited
                dropdownColor: Colors.white, // Optional: Set dropdown background color
                items: dropDownItems.map((item) => DropdownMenuItem<String>(
                      value: item['label'],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: SizedBox(
                          width: double.infinity, 
                          child: Row(
                            children: [
                              item['isGroup'] // Check if the item is a group
                                  ? Icon(IconsaxPlusLinear.routing, size: 16, color: black)
                                  : Icon(IconsaxPlusLinear.location, size: 16, color: black),

                              SizedBox(width: 8),
                              Text(
                                item['label'],
                                style: TextStyle(fontSize: 14)
                              ),
                            ],
                          )
                        ),
                      ),
                    ))
                .toList(),
                onChanged: (val) {
                  if (val != null) {
                    onValueChanged(val);
                  }
                },
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: Colors.grey, // Corrected to use a valid color
                    fontSize: 14,
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
              ),
            ),
          ),
        )

      ],
    );
  }
}