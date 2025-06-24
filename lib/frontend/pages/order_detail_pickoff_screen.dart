import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb; // <-- 1. Impor kIsWeb
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_ourecycle/backend/controllers/order_controller.dart';
import 'package:project_ourecycle/frontend/widgets/order_detail_widgets/curved_detail_header_clipper.dart';
import 'package:project_ourecycle/frontend/widgets/order_detail_widgets/delivery_info_widget.dart';
import 'package:project_ourecycle/frontend/widgets/order_detail_widgets/detail_screen_header.dart';
import 'package:project_ourecycle/frontend/widgets/order_detail_widgets/photo_upload_widget.dart';
import 'package:project_ourecycle/frontend/widgets/order_detail_widgets/plastik_info_card.dart';
import 'package:project_ourecycle/frontend/widgets/order_detail_widgets/schedule_section_widget.dart';
import 'package:project_ourecycle/frontend/widgets/order_detail_widgets/weight_selector_widget.dart';


class OrderDetailPickOffScreen extends StatelessWidget {
  final String wasteCategoryName;
  final double pricePerKg;

  const OrderDetailPickOffScreen({
    super.key,
    required this.wasteCategoryName,
    required this.pricePerKg,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    final List<String> weights = ['5', '10', '15', '20', '25'];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          // ... (Header tidak berubah)
          Positioned(
            top: 0, left: 0, right: 0,
            child: SizedBox(height: MediaQuery.of(context).size.height * 0.22, child: ClipPath(clipper: CurvedDetailHeaderClipper(), child: Container(color: Colors.green.shade400))),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DetailScreenHeader(title: 'Order Detail'),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PlastikInfoCard(imageUrl: 'assets/plastic-bottles.jpg', title: wasteCategoryName),
                        const SizedBox(height: 24),
                        Obx(() => WeightSelectorWidget(
                              weights: weights,
                              selectedWeight: controller.selectedWeight.value,
                              onWeightSelected: (weight) => controller.selectWeight(weight),
                            )),
                        const SizedBox(height: 24),

                        // <-- 2. PERBAIKAN UTAMA DI SINI
                        Obx(() {
                          if (controller.selectedImage.value != null) {
                            final imageFile = controller.selectedImage.value!;
                            // Cek apakah platform adalah Web
                            if (kIsWeb) {
                              // Jika Web, gunakan Image.network dengan path blob URL
                              return Center(child: Image.network(imageFile.path, height: 150, width: 150, fit: BoxFit.cover));
                            } else {
                              // Jika bukan Web (Mobile/Desktop), gunakan Image.file
                              return Center(child: Image.file(File(imageFile.path), height: 150, width: 150, fit: BoxFit.cover));
                            }
                          } else {
                            // Jika belum ada gambar, tampilkan tombol upload
                            return PhotoUploadWidget(onUploadTap: () => controller.pickImage());
                          }
                        }),
                        // ... (sisa widget tidak berubah)
                        const SizedBox(height: 24),
                        Obx(() => ScheduleSectionWidget(
                              sectionTitle: 'Waktu PickOff',
                              timeFieldLabel: 'Waktu Penjemputan',
                              timeFieldHint: controller.selectedTime.value?.format(context) ?? 'Pilih Waktu Penjemputan',
                              timeController: TextEditingController(),
                              onTimeTap: () => controller.selectTime(context),
                              dateFieldLabel: 'Tanggal Penjemputan',
                              dateFieldHint: controller.selectedDate.value != null ? DateFormat('dd MMMM yyyy').format(controller.selectedDate.value!) : 'Pilih Tanggal Penjemputan',
                              dateController: TextEditingController(),
                              onDateTap: () => controller.selectDate(context),
                            )),
                        const SizedBox(height: 24),
                        DeliveryInfoWidget(
                          sectionTitle: 'Informasi Penjemputan',
                          phoneLabel: 'Masukkan No.Telp',
                          phoneHint: 'Masukkan No.Telp',
                          phoneController: controller.phoneController,
                          addressLabel: 'Masukkan Alamat Lengkap',
                          addressHint: 'Masukkan Alamat Lengkap',
                          addressController: controller.addressController,
                        ),
                        const SizedBox(height: 100),
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
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1, blurRadius: 5, offset: const Offset(0, -2))],
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              ),
              child: Obx(() => ElevatedButton(
                    onPressed: controller.isLoading
                        ? null
                        : () => controller.processOrder(
                              context,
                              wasteCategoryName: wasteCategoryName,
                              pricePerKg: pricePerKg,
                              orderType: 'PickOff',
                            ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: controller.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Proses Order', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}