import 'package:flutter/material.dart';

class PhotoUploadWidget extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback onUploadTap;

  const PhotoUploadWidget({
    super.key,
    this.title = "Foto Sampahmu",
    this.buttonText = "Upload Foto Sampah",
    required this.onUploadTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: onUploadTap,
          child: Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey.shade400, width: 1.5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.grey[600],
                  size: 30,
                ),
                const SizedBox(height: 8),
                Text(buttonText, style: TextStyle(color: Colors.grey[700])),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
