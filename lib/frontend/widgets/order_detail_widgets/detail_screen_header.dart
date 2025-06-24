import 'package:flutter/material.dart';

class DetailScreenHeader extends StatelessWidget {
  final String title;
  const DetailScreenHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 10.0,
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          const SizedBox(width: 8),
          Expanded( // Agar title bisa mengisi ruang dan tetap di tengah jika diinginkan
            child: Text(
              title,
              textAlign: TextAlign.center, // Atau sesuaikan alignment
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 48), // Placeholder agar title bisa benar-benar di tengah (sesuaikan ukurannya)
        ],
      ),
    );
  }
}