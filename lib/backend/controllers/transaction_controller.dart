// backend/controllers/transaction_controller.dart

import 'package:get/get.dart';
import 'package:project_ourecycle/backend/datasources/order_datasource.dart';
import 'package:project_ourecycle/backend/models/order_model.dart';

class TransactionController extends GetxController {
  // --- STATE MANAGEMENT ---

  // State untuk menandai proses loading
  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  // Variabel reaktif untuk menampung semua pesanan dari datasource
  final _allOrders = <OrderModel>[].obs;

  // --- COMPUTED PROPERTIES (GETTERS) ---
  // Getter ini secara otomatis memfilter daftar '_allOrders' untuk tab "In Progress"
  List<OrderModel> get inProgressOrders => 
      _allOrders.where((order) => order.status == 'in-progress').toList();

  // Getter ini secara otomatis memfilter daftar '_allOrders' untuk tab "Completed"
  List<OrderModel> get completedOrders => 
      _allOrders.where((order) => order.status == 'completed').toList();


  // --- LIFECYCLE METHOD ---
  @override
  void onInit() {
    super.onInit();
    // Panggil fungsi untuk mengambil data saat controller pertama kali dibuat
    fetchOrders();
  }

  // --- FUNGSI UNTUK MENGAMBIL DATA ---
  Future<void> fetchOrders() async {
    // Mulai loading
    _isLoading.value = true;
    
    // Panggil datasource
    final result = await OrderDatasource.getOrders();

    // Hentikan loading
    _isLoading.value = false;

    result.fold(
      (errorMessage) {
        // Jika gagal, tampilkan pesan error
        Get.snackbar('Error', 'Gagal memuat riwayat transaksi: $errorMessage');
      },
      (orderList) {
        // Jika berhasil, perbarui state '_allOrders' dengan data yang didapat
        _allOrders.value = orderList;
      },
    );
  }
}