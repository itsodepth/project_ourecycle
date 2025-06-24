import 'package:flutter/material.dart';
import 'package:project_ourecycle/backend/models/waste_category_model.dart';
import 'package:project_ourecycle/frontend/pages/order_screen.dart';

class ProductInfoSection extends StatelessWidget {
  final OrderCategory? selectedCategory;
  final ValueChanged<OrderCategory?> onCategoryChanged;
  // Tambahkan parameter baru untuk menerima data kategori
  final WasteCategoryModel category;

  const ProductInfoSection({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            // Gunakan data dinamis
            child: Text(category.name, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.grey.shade800)),
          ),
          const SizedBox(height: 8),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.eco, color: Colors.green, size: 20),
                const SizedBox(width: 8),
                // Gunakan data dinamis
                Text(category.info ?? '', style: TextStyle(fontSize: 16, color: Colors.green.shade700, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text("About", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey.shade800)),
          const SizedBox(height: 8),
          // Teks 'About' bisa juga dibuat dinamis dengan menambahkan atribut baru di Appwrite
          const Text("Sampah plastik merupakan salah satu jenis sampah yang memberikan ancaman serius terhadap lingkungan...", textAlign: TextAlign.justify),
          const SizedBox(height: 24),
          Text("Harga Per KG", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey.shade800)),
          const SizedBox(height: 4),
          // Gunakan data dinamis
          Text("Rp${category.pricePerKg?.toStringAsFixed(0) ?? '0'}/Kg", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green.shade700)),
          const SizedBox(height: 24),
          Text("Pilih Kategori", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey.shade800)),
          const SizedBox(height: 8),
          _buildCategoryRadio(OrderCategory.pickOff, "PickOff"),
          _buildCategoryRadio(OrderCategory.dropOff, "DropOff"),
        ],
      ),
    );
  }

  Widget _buildCategoryRadio(OrderCategory categoryValue, String title) {
    return RadioListTile<OrderCategory>(
      title: Text(title),
      value: categoryValue,
      groupValue: selectedCategory,
      onChanged: onCategoryChanged,
      activeColor: Colors.green.shade600,
      contentPadding: EdgeInsets.zero,
    );
  }
}