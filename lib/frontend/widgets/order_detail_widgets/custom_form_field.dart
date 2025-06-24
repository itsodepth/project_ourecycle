import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String hintText;
  final int maxLines;
  final TextInputType keyboardType;
  final VoidCallback? onTapIcon;
  final bool readOnly;
  final IconData? suffixIcon; // Tambahkan jika ingin ada ikon di kanan

  const CustomFormField({
    super.key,
    required this.controller,
    this.labelText,
    required this.hintText,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.onTapIcon,
    this.readOnly = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: TextStyle(
              fontSize: 14,
              color: Colors.green.shade700, // Warna label hijau dari desain
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
        ],
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          readOnly: readOnly || (onTapIcon != null),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey.shade500),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.green.shade400, width: 1.5),
            ),
            suffixIcon:
                suffixIcon != null &&
                        onTapIcon ==
                            null // Hanya tampilkan jika bukan untuk picker
                    ? Icon(suffixIcon, color: Colors.grey.shade600)
                    : null,
          ),
          onTap: onTapIcon != null && !readOnly ? onTapIcon : null,
        ),
      ],
    );
  }
}
