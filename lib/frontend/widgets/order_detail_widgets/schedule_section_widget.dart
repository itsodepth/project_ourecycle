import 'package:flutter/material.dart';
import 'custom_form_field.dart';

class ScheduleSectionWidget extends StatelessWidget {
  final String sectionTitle;
  final String timeFieldLabel;
  final String timeFieldHint;
  final TextEditingController timeController;
  final VoidCallback onTimeTap;

  final String dateFieldLabel;
  final String dateFieldHint;
  final TextEditingController dateController;
  final VoidCallback onDateTap;

  const ScheduleSectionWidget({
    super.key,
    required this.sectionTitle,
    required this.timeFieldLabel,
    required this.timeFieldHint,
    required this.timeController,
    required this.onTimeTap,
    required this.dateFieldLabel,
    required this.dateFieldHint,
    required this.dateController,
    required this.onDateTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionTitle,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        CustomFormField(
          controller: timeController,
          labelText: timeFieldLabel,
          hintText: timeFieldHint,
          onTapIcon: onTimeTap, // Untuk memicu time picker
        ),
        const SizedBox(height: 12),
        CustomFormField(
          controller: dateController,
          labelText: dateFieldLabel,
          hintText: dateFieldHint,
          onTapIcon: onDateTap, // Untuk memicu date picker
        ),
      ],
    );
  }
}
