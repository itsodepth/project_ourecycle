import 'package:flutter/material.dart';
import 'package:project_ourecycle/widgets/order_detail_widgets/curved_detail_header_clipper.dart';
import 'package:project_ourecycle/widgets/order_detail_widgets/detail_screen_header.dart'; // Menggunakan header alternatif
import 'package:project_ourecycle/widgets/order_detail_widgets/plastik_info_card.dart';
import 'package:project_ourecycle/widgets/order_detail_widgets/weight_selector_widget.dart';
import 'package:project_ourecycle/widgets/order_detail_widgets/photo_upload_widget.dart';
import 'package:project_ourecycle/widgets/order_detail_widgets/schedule_section_widget.dart';
import 'package:project_ourecycle/widgets/order_detail_widgets/delivery_info_widget.dart';
import 'package:project_ourecycle/widgets/order_detail_widgets/order_summary_details_widget.dart';

// import 'package:intl/intl.dart'; // contoh jika menggunakan intl

class OrderDetailDropOffScreen extends StatefulWidget {
  const OrderDetailDropOffScreen({super.key});

  @override
  State<OrderDetailDropOffScreen> createState() =>
      _OrderDetailDropOffScreenState();
}

class _OrderDetailDropOffScreenState extends State<OrderDetailDropOffScreen> {
  String? _selectedWeight;
  final List<String> _weights = ['5', '10', '15', '20', '25'];

  final TextEditingController _waktuPengirimanController =
      TextEditingController();
  final TextEditingController _tanggalPengirimanController =
      TextEditingController();
  final TextEditingController _noTelpController = TextEditingController();
  final TextEditingController _alamatPengirimanController =
      TextEditingController();

  String _detailWaktu = "08.00 - 13.00"; // Tetap "Penjemputan" sesuai gambar
  String _detailTanggal = "19 May 2025"; // Tetap "Penjemputan" sesuai gambar
  double _pajakRate = 0.11;
  double _subTotal = 16036;

  String _formatCurrency(double amount) {
    return "Rp${amount.toStringAsFixed(0)}";
  }

  @override
  void dispose() {
    _waktuPengirimanController.dispose();
    _tanggalPengirimanController.dispose();
    _noTelpController.dispose();
    _alamatPengirimanController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      helpText: 'Pilih Tanggal Pengiriman',
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.green.shade600,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        controller.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  Future<void> _selectTime(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: 'Pilih Waktu Pengiriman',
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.green.shade600,
              onPrimary: Colors.white,
              onSurface: Colors.black,
              surface: Colors.white,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double pajakAmount = _subTotal * _pajakRate;
    double totalAmount = _subTotal + pajakAmount;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.22,
              child: ClipPath(
                clipper: CurvedDetailHeaderClipper(),
                child: Container(color: Colors.green.shade400),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DetailScreenHeader(
                  title: 'Order Detail',
                ), // Menggunakan widget header kustom
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const PlastikInfoCard(
                          imageUrl:
                              'assets/plastic-bottles.jpg', // Pastikan path aset benar
                        ),
                        const SizedBox(height: 24),
                        WeightSelectorWidget(
                          weights: _weights,
                          selectedWeight: _selectedWeight,
                          onWeightSelected: (weight) {
                            setState(() {
                              _selectedWeight = weight;
                            });
                          },
                        ),
                        const SizedBox(height: 24),
                        PhotoUploadWidget(
                          onUploadTap: () {
                            // --- Backend Comment: Handle upload foto ---
                            print('Upload Foto Sampah tapped');
                          },
                        ),
                        const SizedBox(height: 24),
                        ScheduleSectionWidget(
                          sectionTitle: 'Waktu DropOff',
                          timeFieldLabel: 'Waktu Pengiriman',
                          timeFieldHint:
                              'Masukkan Tanggal Pengiriman dd/mm/yyyy', // Sesuai gambar
                          timeController: _waktuPengirimanController,
                          onTimeTap:
                              () => _selectTime(
                                context,
                                _waktuPengirimanController,
                              ),
                          dateFieldLabel: 'Tanggal Pengiriman',
                          dateFieldHint:
                              'Masukkan Waktu Pengiriman dd/mm/yyyy', // Sesuai gambar
                          dateController: _tanggalPengirimanController,
                          onDateTap:
                              () => _selectDate(
                                context,
                                _tanggalPengirimanController,
                              ),
                        ),
                        const SizedBox(height: 24),
                        DeliveryInfoWidget(
                          sectionTitle: 'Informasi Pengiriman',
                          phoneLabel: 'Masukkan No.Telp',
                          phoneHint: 'Masukkan No.Telp',
                          phoneController: _noTelpController,
                          addressLabel: 'Pilih Alamat Pengiriman',
                          addressHint: 'Pilih Alamat Pengiriman',
                          addressController: _alamatPengirimanController,
                        ),
                        const SizedBox(height: 24),
                        OrderSummaryDetailsWidget(
                          // Sesuai gambar, label masih "Penjemputan", sesuaikan jika perlu
                          waktuLabel: 'Waktu Penjemputan',
                          waktuValue: _detailWaktu,
                          tanggalLabel: 'Tanggal Penjemputan',
                          tanggalValue: _detailTanggal,
                          pajakValue: _formatCurrency(pajakAmount),
                          totalValue: _formatCurrency(totalAmount),
                        ),
                        const SizedBox(height: 80), // Space for bottom button
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 15.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, -2),
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  // --- Backend Comment: Proses Order DropOff ---
                  print('Proses Order DropOff Tapped. Berat: $_selectedWeight');
                  // Kumpulkan data lain dari controllers...
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Proses Order',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper _buildTextField dan _buildDetailRow dihapus karena sudah digantikan widget
}
// CurvedHeaderClipper sudah dipindah