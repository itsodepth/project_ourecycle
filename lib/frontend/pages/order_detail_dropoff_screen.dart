import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_ourecycle/backend/controllers/order_controller.dart';
import 'package:project_ourecycle/backend/models/dropoff_location_model.dart';
import 'package:project_ourecycle/frontend/widgets/order_detail_widgets/curved_detail_header_clipper.dart';
import 'package:project_ourecycle/frontend/widgets/order_detail_widgets/detail_screen_header.dart';
import 'package:project_ourecycle/frontend/widgets/order_detail_widgets/photo_upload_widget.dart';
import 'package:project_ourecycle/frontend/widgets/order_detail_widgets/plastik_info_card.dart';
import 'package:project_ourecycle/frontend/widgets/order_detail_widgets/schedule_section_widget.dart';
import 'package:project_ourecycle/frontend/widgets/order_detail_widgets/weight_selector_widget.dart';


class OrderDetailDropOffScreen extends StatelessWidget {
  final String wasteCategoryName;
  final double pricePerKg;

  const OrderDetailDropOffScreen({
    super.key,
    required this.wasteCategoryName,
    required this.pricePerKg,
  });

  @override
  Widget build(BuildContext context) {
    // Gunakan Get.put() untuk membuat instance baru controller untuk alur ini
    final controller = Get.put(OrderController());
    final List<String> weights = ['5', '10', '15', '20', '25'];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.22,
              child: ClipPath(clipper: CurvedDetailHeaderClipper(), child: Container(color: Colors.green.shade400)),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DetailScreenHeader(title: 'Order Detail (Drop Off)'),
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
                        Obx(() {
                          if (controller.selectedImage.value != null) {
                            if (kIsWeb) {
                              return Center(child: Image.network(controller.selectedImage.value!.path, height: 150, width: 150, fit: BoxFit.cover));
                            } else {
                              return Center(child: Image.file(File(controller.selectedImage.value!.path), height: 150, width: 150, fit: BoxFit.cover));
                            }
                          } else {
                            return PhotoUploadWidget(onUploadTap: () => controller.pickImage());
                          }
                        }),
                        const SizedBox(height: 24),
                        Obx(() => ScheduleSectionWidget(
                              sectionTitle: 'Waktu Drop Off',
                              timeFieldLabel: 'Waktu Pengantaran',
                              timeFieldHint: controller.selectedTime.value?.format(context) ?? 'Pilih Waktu Pengantaran',
                              timeController: TextEditingController(),
                              onTimeTap: () => controller.selectTime(context),
                              dateFieldLabel: 'Tanggal Pengantaran',
                              dateFieldHint: controller.selectedDate.value != null ? DateFormat('dd MMMM yy').format(controller.selectedDate.value!) : 'Pilih Tanggal Pengantaran',
                              dateController: TextEditingController(),
                              onDateTap: () => controller.selectDate(context),
                            )),
                        const SizedBox(height: 24),

                        // ================== BAGIAN UTAMA YANG BERBEDA ==================
                        const Text("Pilih Lokasi Drop Off", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        Obx(() {
                          if (controller.isLoadingLocations) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (controller.dropOffLocations.isEmpty) {
                            return const Text("Gagal memuat lokasi atau tidak ada lokasi tersedia.");
                          }
                          return DropdownButtonFormField<DropOffLocationModel>(
                            value: controller.selectedLocation.value,
                            hint: const Text("Pilih lokasi..."),
                            isExpanded: true,
                            items: controller.dropOffLocations.map((location) {
                              return DropdownMenuItem(
                                value: location,
                                child: Text(location.name),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              controller.selectLocation(newValue);
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                            ),
                          );
                        }),
                        const SizedBox(height: 12),
                        // Tampilkan alamat dari lokasi yang dipilih
                        Obx(() {
                          if (controller.selectedLocation.value != null) {
                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)
                              ),
                              child: Text(
                                "Alamat: ${controller.selectedLocation.value!.address}",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        }),
                        const SizedBox(height: 24),
                        // Kita tetap butuh nomor telepon untuk konfirmasi
                        const Text("Informasi Kontak", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: controller.phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: "Masukkan No. Telp Anda",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                          ),
                        ),
                        // =============================================================
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
                              orderType: 'DropOff', // Kirim tipe order yang benar
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