import 'package:flutter/material.dart';

// Custom Clipper untuk efek gelombang di header
class WaveHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50); // Titik awal kiri, sedikit di atas bawah
    // Kurva pertama untuk gelombang
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height - 30);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );
    // Kurva kedua untuk gelombang
    var secondControlPoint = Offset(size.width * 3 / 4, size.height - 60);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0); // Garis ke kanan atas
    path.lineTo(0, 0); // Garis ke kiri atas (Menutup path dengan benar)
    path.close(); // Tutup path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}