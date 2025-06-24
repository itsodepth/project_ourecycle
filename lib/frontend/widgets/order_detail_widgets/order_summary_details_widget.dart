import 'package:flutter/material.dart';
import 'detail_row.dart';

class OrderSummaryDetailsWidget extends StatelessWidget {
  final String sectionTitle;
  final String waktuLabel; // "Waktu Penjemputan" atau "Waktu Pengiriman"
  final String waktuValue;
  final String tanggalLabel; // "Tanggal Penjemputan" atau "Tanggal Pengiriman"
  final String tanggalValue;
  final String pajakLabel;
  final String pajakValue;
  final String totalLabel;
  final String totalValue;

  const OrderSummaryDetailsWidget({
    super.key,
    this.sectionTitle = "Details",
    required this.waktuLabel,
    required this.waktuValue,
    required this.tanggalLabel,
    required this.tanggalValue,
    this.pajakLabel = "Pajak 11%",
    required this.pajakValue,
    this.totalLabel = "Total",
    required this.totalValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionTitle,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        DetailRow(label: waktuLabel, value: waktuValue),
        DetailRow(label: tanggalLabel, value: tanggalValue),
        DetailRow(label: pajakLabel, value: pajakValue),
        const Divider(height: 20, thickness: 1),
        DetailRow(label: totalLabel, value: totalValue, isTotal: true),
      ],
    );
  }
}