import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ourecycle/frontend/pages/order_detail_dropoff_screen.dart';
import 'package:project_ourecycle/frontend/pages/order_detail_pickoff_screen.dart';
import 'package:project_ourecycle/frontend/pages/order_screen.dart';

class BottomOrderActionBar extends StatelessWidget {
  final OrderCategory? selectedCategory;
  
  // Parameter untuk menerima data dinamis
  final String wasteCategoryName;
  final double pricePerKg;

  const BottomOrderActionBar({
    super.key,
    required this.selectedCategory,
    required this.wasteCategoryName,
    required this.pricePerKg,
  });

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
          // Menampilkan harga secara dinamis
          Text(
            "Rp${pricePerKg.toStringAsFixed(0)}/Kg",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedCategory == null) {
                Get.snackbar('Peringatan', 'Silakan pilih kategori PickOff atau DropOff terlebih dahulu.');
                return;
              }

              if (selectedCategory == OrderCategory.pickOff) {
                Get.to(() => OrderDetailPickOffScreen(
                      wasteCategoryName: wasteCategoryName,
                      pricePerKg: pricePerKg,
                    ));
              } else if (selectedCategory == OrderCategory.dropOff) {
                // ================== PERBAIKAN DI SINI ==================
                // Aktifkan pengiriman data untuk alur DropOff juga
                Get.to(() => OrderDetailDropOffScreen(
                      wasteCategoryName: wasteCategoryName,
                      pricePerKg: pricePerKg,
                    ));
                // =======================================================
              }
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