import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_ourecycle/backend/config/appwrite.dart';
import 'package:project_ourecycle/backend/controllers/transaction_controller.dart';
import 'package:project_ourecycle/backend/models/order_model.dart';
import 'package:project_ourecycle/frontend/pages/transaksi_detail_screen.dart'; // Impor halaman detail

class TransaksiScreen extends StatefulWidget {
  const TransaksiScreen({super.key});

  @override
  State<TransaksiScreen> createState() => _TransaksiScreenState();
}

class _TransaksiScreenState extends State<TransaksiScreen> {
  final controller = Get.put(TransactionController());
  bool isInProgress = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Center(
                child: Text('Transaksi', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => isInProgress = true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isInProgress ? const Color(0xFF079119) : Colors.grey,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('In Progress', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => setState(() => isInProgress = false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !isInProgress ? const Color(0xFF079119) : Colors.grey,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Completed', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                final ordersToShow = isInProgress 
                                    ? controller.inProgressOrders 
                                    : controller.completedOrders;

                // ================== PERBAIKAN 1: PULL-TO-REFRESH ==================
                return RefreshIndicator(
                  onRefresh: () => controller.fetchOrders(),
                  child: ordersToShow.isEmpty
                      ? Center(
                          child: ListView( // Dibuat ListView agar bisa di-scroll saat ditarik
                            children: const [
                              SizedBox(height: 150),
                              Center(child: Text('Tidak ada transaksi di kategori ini.')),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: ordersToShow.length,
                          itemBuilder: (context, index) {
                            final order = ordersToShow[index];
                            // ================== PERBAIKAN 2: ITEM BISA DIKLIK ==================
                            return GestureDetector(
                              onTap: () {
                                // Navigasi ke halaman detail saat item diklik
                                Get.to(() => TransaksiDetailScreen(order: order));
                              },
                              child: OrderItemCard(order: order),
                            );
                            // ===================================================================
                          },
                        ),
                );
                // ====================================================================
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderItemCard extends StatelessWidget {
  final OrderModel order;

  const OrderItemCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd MMMM yyyy, HH:mm').format(order.scheduledAt);
    final formattedPrice = 'Rp${order.totalPrice.toStringAsFixed(0)}';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.1)),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 4)],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: (order.photoId != null && order.photoId!.isNotEmpty)
                ? Image.network(
                    Appwrite.getImageUrl(order.photoId!),
                    width: 80, height: 80, fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported, size: 80, color: Colors.grey),
                  )
                : Image.asset(
                    'assets/ourecycle.png',
                    width: 80, height: 80, fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.wasteCategoryName,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text('${order.weight} Kg - ${order.orderType}'),
                Text(formattedDate, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            formattedPrice,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          ),
        ],
      ),
    );
  }
}