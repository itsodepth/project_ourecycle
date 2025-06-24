// backend/controllers/order_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_ourecycle/backend/config/app_route.dart';
import 'package:project_ourecycle/backend/controllers/transaction_controller.dart'; // <-- 1. Impor TransactionController
import 'package:project_ourecycle/backend/datasources/location_datasource.dart';
import 'package:project_ourecycle/backend/datasources/order_datasource.dart';
import 'package:project_ourecycle/backend/models/dropoff_location_model.dart';
import 'package:project_ourecycle/backend/models/user_model.dart';
import 'package:project_ourecycle/backend/services/session_service.dart';

class OrderController extends GetxController {
  // ... (semua state dan fungsi lainnya tidak berubah)
  final selectedWeight = Rxn<String>();
  final selectedImage = Rxn<XFile>();
  final selectedDate = Rxn<DateTime>();
  final selectedTime = Rxn<TimeOfDay>();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  final ImagePicker _picker = ImagePicker();
  final _isLoadingLocations = true.obs;
  bool get isLoadingLocations => _isLoadingLocations.value;
  final dropOffLocations = <DropOffLocationModel>[].obs;
  final selectedLocation = Rxn<DropOffLocationModel>();

  @override
  void onInit() {
    super.onInit();
    fetchDropOffLocations();
  }
  
  void selectWeight(String weight) => selectedWeight.value = weight;
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) selectedImage.value = image;
  }
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 30)));
    if (picked != null) selectedDate.value = picked;
  }
  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) selectedTime.value = picked;
  }
  Future<void> fetchDropOffLocations() async {
    _isLoadingLocations.value = true;
    dropOffLocations.value = await LocationDatasource.getDropOffLocations();
    _isLoadingLocations.value = false;
  }
  void selectLocation(DropOffLocationModel? location) => selectedLocation.value = location;

  void processOrder(BuildContext context, {
    required String wasteCategoryName,
    required double pricePerKg,
    required String orderType,
  }) async {
    // ... (validasi tidak berubah)
    String finalAddress;
    if (orderType == 'PickOff') {
      if (addressController.text.isEmpty) { Get.snackbar('Error', 'Alamat penjemputan wajib diisi.'); return; }
      finalAddress = addressController.text;
    } else {
      if (selectedLocation.value == null) { Get.snackbar('Error', 'Silakan pilih lokasi drop-off.'); return; }
      finalAddress = selectedLocation.value!.address;
    }
    if (selectedWeight.value == null || selectedDate.value == null || selectedTime.value == null || phoneController.text.isEmpty) {
      Get.snackbar('Error', 'Semua informasi wajib diisi.'); return;
    }

    _isLoading.value = true;
    UserModel? currentUser = await SessionService.getUser();
    if (currentUser == null || currentUser.id == null) {
      Get.snackbar('Error', 'Gagal mendapatkan data pengguna. Silakan login ulang.');
      _isLoading.value = false;
      return;
    }

    final scheduledAt = DateTime(selectedDate.value!.year, selectedDate.value!.month, selectedDate.value!.day, selectedTime.value!.hour, selectedTime.value!.minute);
    
    final result = await OrderDatasource.createOrder(
      userId: currentUser.id!, userName: currentUser.name ?? 'Nama tidak ada',
      wasteCategoryName: wasteCategoryName, weight: double.parse(selectedWeight.value!),
      orderType: orderType, address: finalAddress, phoneNumber: phoneController.text,
      scheduledAt: scheduledAt, totalPrice: double.parse(selectedWeight.value!) * pricePerKg,
      taxAmount: (double.parse(selectedWeight.value!) * pricePerKg) * 0.11, photoId: null,
    );
    
    _isLoading.value = false;

    result.fold(
      (errorMessage) {
        Get.snackbar('Gagal', errorMessage, backgroundColor: Colors.red, colorText: Colors.white);
      },
      (success) {
        Get.snackbar('Berhasil', 'Pesanan Anda telah dibuat.', backgroundColor: Colors.green, colorText: Colors.white);
        
        // ================== PERBAIKAN AUTO-REFRESH DI SINI ==================
        // 1. Cek apakah TransactionController sudah pernah dibuat.
        if (Get.isRegistered<TransactionController>()) {
          // 2. Jika sudah, cari instance-nya dan panggil fungsi fetchOrders()
          final transactionController = Get.find<TransactionController>();
          transactionController.fetchOrders();
        }
        // ====================================================================

        // 3. Kembali ke halaman utama.
        Get.offAllNamed(AppRoute.dashboard.name);
      },
    );
  }
  
  @override
  void onClose() {
    phoneController.dispose();
    addressController.dispose();
    super.onClose();
  }
}