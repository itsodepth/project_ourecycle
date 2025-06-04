import 'package:flutter/material.dart';

class TransaksiCompleted extends StatelessWidget {
  const TransaksiCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    // Ganti bagian ini dengan data dari database
    final List<Map<String, String>> orders = [
      {
        'imageUrl': 'https://via.placeholder.com/150',
        'orderId': '231936',
        'description': 'Botol Plastik 5Kg',
        'total': 'Rp10.000',
      },
      {
        'imageUrl': 'https://via.placeholder.com/150',
        'orderId': '231937',
        'description': 'Botol Plastik 3Kg',
        'total': 'Rp19.500',
      },
      {
        'imageUrl': 'https://via.placeholder.com/150',
        'orderId': '231938',
        'description': 'Botol Plastik 7Kg',
        'total': 'Rp25.000',
      },
      {
        'imageUrl': 'https://via.placeholder.com/150',
        'orderId': '231938',
        'description': 'Botol Plastik 7Kg',
        'total': 'Rp25.000',
      },
      {
        'imageUrl': 'https://via.placeholder.com/150',
        'orderId': '231938',
        'description': 'Botol Plastik 7Kg',
        'total': 'Rp25.000',
      },
      {
        'imageUrl': 'https://via.placeholder.com/150',
        'orderId': '231938',
        'description': 'Botol Plastik 7Kg',
        'total': 'Rp25.000',
      },
      {
        'imageUrl': 'https://via.placeholder.com/150',
        'orderId': '231938',
        'description': 'Botol Plastik 7Kg',
        'total': 'Rp25.000',
      },
      {
        'imageUrl': 'https://via.placeholder.com/150',
        'orderId': '231938',
        'description': 'Botol Plastik 7Kg',
        'total': 'Rp25.000',
      },
      {
        'imageUrl': 'https://via.placeholder.com/150',
        'orderId': '231938',
        'description': 'Botol Plastik 7Kg',
        'total': 'Rp25.000',
      },
      {
        'imageUrl': 'https://via.placeholder.com/150',
        'orderId': '231938',
        'description': 'Botol Plastik 7Kg',
        'total': 'Rp25.000',
      },
      {
        'imageUrl': 'https://via.placeholder.com/150',
        'orderId': '231938',
        'description': 'Botol Plastik 7Kg',
        'total': 'Rp25.000',
      },
    ];

    // Gunakan FutureBuilder jika data diambil dari API atau database

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return OrderItemCard(
          imageUrl: order['imageUrl']!,
          orderId: order['orderId']!,
          description: order['description']!,
          total: order['total']!,
        );
      },
    );
  }
}

class OrderItemCard extends StatelessWidget {
  final String imageUrl;
  final String orderId;
  final String description;
  final String total;

  const OrderItemCard({
    super.key,
    required this.imageUrl,
    required this.orderId,
    required this.description,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl, // Ganti dengan URL gambar yang sesuai
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) => const Icon(
                    Icons.broken_image,
                    size: 80,
                  ), // Placeholder jika gambar gagal dimuat
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pesanan #$orderId',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                Text(description),
                const SizedBox(height: 8),
              ],
            ),
          ),
          Text(
            total,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
