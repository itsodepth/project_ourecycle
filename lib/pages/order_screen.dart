import 'package:flutter/material.dart';
import 'package:project_ourecycle/widgets/order_screen_widgets/order_header_and_image.dart';
import 'package:project_ourecycle/widgets/order_screen_widgets/product_info_section.dart';
import 'package:project_ourecycle/widgets/order_screen_widgets/bottom_order_action_bar.dart';

enum OrderCategory { pickOff, dropOff }

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  OrderCategory? _selectedCategory = OrderCategory.pickOff; // Kategori default

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
            const OrderHeaderAndImage(), // Menggunakan widget yang sudah dipisah
            const SizedBox(height: 80 + 20.0), // Jarak dari gambar
            ProductInfoSection(
              selectedCategory: _selectedCategory,
              onCategoryChanged: _onCategoryChanged,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomOrderActionBar(
        selectedCategory: _selectedCategory,
      ),
    );
  }
}
