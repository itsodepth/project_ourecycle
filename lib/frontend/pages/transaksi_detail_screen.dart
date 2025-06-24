import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_ourecycle/backend/models/order_model.dart';

class TransaksiDetailScreen extends StatelessWidget {
  final OrderModel order;

  const TransaksiDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    // Helper untuk warna status
    final statusColor = order.status == 'in-progress' ? Colors.orange.shade700 : Colors.green.shade700;
    
    return Scaffold(
      backgroundColor: Colors.grey[100], // Beri sedikit warna background
      appBar: AppBar(
        title: Text('Detail Pesanan'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // --- KARTU STATUS ---
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ID Pesanan: #${order.id.substring(0, 8)}...',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      // Chip untuk status yang lebih menonjol
                      Chip(
                        label: Text(
                          order.status.toUpperCase(),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        backgroundColor: statusColor,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    order.wasteCategoryName,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // --- KARTU DETAIL PESANAN ---
          _buildDetailCard(
            title: 'Detail Pesanan',
            children: [
              _buildInfoRow(Icons.line_weight, 'Berat', '${order.weight} Kg'),
              _buildInfoRow(Icons.delivery_dining, 'Tipe Pesanan', order.orderType),
            ],
          ),
          const SizedBox(height: 16),
          
          // --- KARTU INFORMASI PENGIRIMAN ---
          _buildDetailCard(
            title: 'Informasi Pengantaran/Penjemputan',
            children: [
              _buildInfoRow(Icons.calendar_today, 'Jadwal', DateFormat('EEEE, dd MMMM yyyy, HH:mm').format(order.scheduledAt)),
              _buildInfoRow(Icons.location_on, 'Alamat', order.address),
              _buildInfoRow(Icons.phone, 'No. Telepon', order.phoneNumber),
            ],
          ),
          const SizedBox(height: 16),

          // --- KARTU RINCIAN BIAYA ---
          _buildDetailCard(
            title: 'Rincian Pendapatan',
            children: [
              _buildInfoRow(Icons.receipt_long, 'Subtotal', 'Rp${(order.totalPrice - order.taxAmount).toStringAsFixed(0)}'),
              _buildInfoRow(Icons.request_quote, 'Pajak (11%)', 'Rp${order.taxAmount.toStringAsFixed(0)}'),
              const Divider(thickness: 1, height: 24),
              _buildInfoRow(Icons.paid, 'Total Pendapatan', 'Rp${order.totalPrice.toStringAsFixed(0)}', isTotal: true),
            ],
          ),
        ],
      ),
    );
  }

  // Widget baru untuk membuat kartu yang bisa digunakan kembali
  Widget _buildDetailCard({required String title, required List<Widget> children}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }

  // Widget baru untuk membuat baris detail dengan ikon
  Widget _buildInfoRow(IconData icon, String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.green.shade700, size: 20),
          const SizedBox(width: 16),
          Expanded(child: Text(label, style: TextStyle(color: Colors.grey.shade700))),
          const SizedBox(width: 16),
          Expanded(
            flex: 2, // Beri ruang lebih untuk value
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                fontSize: isTotal ? 18 : 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}