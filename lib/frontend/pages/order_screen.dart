import 'package:flutter/material.dart';
import 'package:project_ourecycle/backend/models/waste_category_model.dart';
import 'package:project_ourecycle/frontend/widgets/order_screen_widgets/order_header_and_image.dart';
import 'package:project_ourecycle/frontend/widgets/order_screen_widgets/product_info_section.dart';
import 'package:project_ourecycle/frontend/widgets/order_screen_widgets/bottom_order_action_bar.dart';

enum OrderCategory { pickOff, dropOff }

class OrderScreen extends StatefulWidget {
  // Tambahkan parameter untuk menerima data kategori
  final WasteCategoryModel category;
  const OrderScreen({super.key, required this.category});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  OrderCategory? _selectedCategory = OrderCategory.pickOff;

  void _onCategoryChanged(OrderCategory? value) {
    setState(() {
      _selectedCategory = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kirim imageId ke header
            OrderHeaderAndImage(imageId: widget.category.imageId),
            const SizedBox(height: 80 + 20.0),
            // Kirim seluruh objek kategori ke ProductInfoSection
            ProductInfoSection(
              category: widget.category,
              selectedCategory: _selectedCategory,
              onCategoryChanged: _onCategoryChanged,
            ),
          ],
        ),
      ),
      // Kirim data yang relevan ke BottomOrderActionBar
      bottomNavigationBar: BottomOrderActionBar(
        selectedCategory: _selectedCategory,
        wasteCategoryName: widget.category.name,
        pricePerKg: widget.category.pricePerKg ?? 0.0,
      ),
    );
  }
}