import 'package:flutter/material.dart';
import 'package:project_ourecycle/pages/order_detail_pickoff_screen.dart';
import 'package:project_ourecycle/pages/order_detail_dropoff_screen.dart';
import 'package:project_ourecycle/pages/order_screen.dart'; // Untuk mengakses OrderCategory enum

class BottomOrderActionBar extends StatelessWidget {
  final OrderCategory? selectedCategory;

  const BottomOrderActionBar({super.key, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ).copyWith(bottom: MediaQuery.of(context).padding.bottom + 15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, -3),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Rp2.000/Kg",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedCategory == OrderCategory.pickOff) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderDetailPickOffScreen(),
                  ),
                );
              } else if (selectedCategory == OrderCategory.dropOff) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderDetailDropOffScreen(),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Silakan pilih kategori terlebih dahulu."),
                  ),
                );
              }
              print("Detail Order Ditekan! Kategori: $selectedCategory");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade600,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
            ),
            child: const Text(
              "Detail Order",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
