import 'package:flutter/material.dart';
import 'package:project_ourecycle/pages/order_screen.dart'; // Untuk mengakses OrderCategory enum

// Anda bisa juga memindahkan enum OrderCategory ke file tersendiri jika digunakan di banyak tempat
// atau biarkan di order_screen.dart dan import seperti di atas.

class ProductInfoSection extends StatelessWidget {
  final OrderCategory? selectedCategory;
  final ValueChanged<OrderCategory?> onCategoryChanged;

  const ProductInfoSection({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Plastik",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.eco, color: Colors.green.shade600, size: 20),
                const SizedBox(width: 8),
                Text(
                  "+900 Terbuang",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "About",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Sampah plastik merupakan salah satu jenis sampah yang memberikan ancaman serius terhadap lingkungan karena selain jumlahnya cenderung semakin besar, kantong plastik adalah jenis sampah yang sulit terurai oleh proses alam (non biodegradable) dan merupakan salah satu pencemar xenobiotik (pencemar yang tidak dikenal oleh sistem biologis di lingkungan) mengakibatkan senyawa pencemar terakumulasi di alam.",
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "Harga Per KG",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Rp2.000/Kg",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "Pilih Kategori",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 8),
          _buildCategoryRadio(OrderCategory.pickOff, "PickOff"),
          _buildCategoryRadio(OrderCategory.dropOff, "DropOff"),
        ],
      ),
    );
  }

  Widget _buildCategoryRadio(OrderCategory categoryValue, String title) {
    return RadioListTile<OrderCategory>(
      title: Text(
        title,
        style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
      ),
      value: categoryValue,
      groupValue: selectedCategory,
      onChanged: onCategoryChanged,
      activeColor: Colors.green.shade600,
      contentPadding: EdgeInsets.zero,
    );
  }
}
