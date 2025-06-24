
import 'package:flutter/material.dart';

class OrderDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const OrderDetailAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent, // Dibuat transparan karena background diurus oleh Stack
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true, // Agar judul di tengah jika tidak ada leading/actions lain
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}