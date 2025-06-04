import 'package:flutter/material.dart';
// Untuk date picker, Anda mungkin memerlukan package tambahan seperti flutter_datetime_picker atau intl untuk formatting
// import 'package:intl/intl.dart'; // contoh jika menggunakan intl

class OrderDetailPickOffScreen extends StatefulWidget {
  const OrderDetailPickOffScreen({super.key});

  @override
  State<OrderDetailPickOffScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailPickOffScreen> {
  String? _selectedWeight;
  final List<String> _weights = ['5', '10', '15', '20', '25'];

  // TextEditingControllers untuk input fields
  final TextEditingController _waktuPenjemputanController =
      TextEditingController();
  final TextEditingController _tanggalPenjemputanController =
      TextEditingController();
  final TextEditingController _noTelpController = TextEditingController();
  final TextEditingController _alamatLengkapController =
      TextEditingController();

  // Variabel untuk detail (ini bisa dihitung atau didapatkan dari backend nantinya)
  String _detailWaktuPenjemputan = "08.00 - 13.00";
  String _detailTanggalPenjemputan = "19 May 2025";
  double _pajakRate = 0.11; // 11%
  double _subTotal =
      16036; // Contoh subtotal sebelum pajak, agar totalnya jadi Rp17.800 (17800 / 1.11)
  // double _hargaPerKg = 2000; // Mungkin diperlukan jika berat mempengaruhi harga

  // Fungsi untuk menghitung total
  String _calculateTotal() {
    // Misalnya, jika ada harga berdasarkan berat:
    // if (_selectedWeight == null) return "Rp0";
    // double berat = double.parse(_selectedWeight!);
    // double currentSubTotal = berat * _hargaPerKg;
    // double totalDenganPajak = currentSubTotal * (1 + _pajakRate);
    // return "Rp${totalDenganPajak.toStringAsFixed(0)}"; // Asumsi pembulatan ke integer

    // Berdasarkan gambar, totalnya sudah fix. Jika dinamis:
    double total = _subTotal * (1 + _pajakRate);
    return "Rp${total.toStringAsFixed(0)}"; // Menghilangkan desimal, sesuaikan format jika perlu
  }

  String _formatCurrency(double amount) {
    // Anda bisa menggunakan package intl untuk formatting mata uang yang lebih baik
    // NumberFormat currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    // return currencyFormatter.format(amount);
    return "Rp${amount.toStringAsFixed(0)}";
  }

  @override
  void dispose() {
    _waktuPenjemputanController.dispose();
    _tanggalPenjemputanController.dispose();
    _noTelpController.dispose();
    _alamatLengkapController.dispose();
    super.dispose();
  }

  // --- Backend Comment: Fungsi untuk memilih tanggal ---
  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    // --- Backend Comment: Biasanya ini akan memanggil native date picker ---
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        // Format tanggal sesuai keinginan (dd/mm/yyyy)
        // controller.text = DateFormat('dd/MM/yyyy').format(picked);
        controller.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
        // --- Backend Comment: Update state atau kirim data tanggal terpilih ---
      });
    }
  }

  // --- Backend Comment: Fungsi untuk memilih waktu ---
  Future<void> _selectTime(
    BuildContext context,
    TextEditingController controller,
  ) async {
    // --- Backend Comment: Biasanya ini akan memanggil native time picker ---
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        // Format waktu sesuai keinginan (HH:mm)
        controller.text = picked.format(context); // Format default
        // --- Backend Comment: Update state atau kirim data waktu terpilih ---
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Perhitungan pajak dan total untuk ditampilkan di section "Details"
    double pajakAmount = _subTotal * _pajakRate;
    double totalAmount = _subTotal + pajakAmount;

    return Scaffold(
      backgroundColor:
          Colors.grey[100], // Warna background utama agak keabu-abuan
      body: Stack(
        children: [
          // Background Green Curved Shape
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height:
                  MediaQuery.of(context).size.height *
                  0.22, // Lebih pendek dari screen sebelumnya
              child: ClipPath(
                clipper:
                    CurvedHeaderClipper(), // Clipper yang sama atau sedikit dimodifikasi
                child: Container(color: Colors.green.shade400),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Bar: Back Button and Title
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 10.0,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // --- Backend Comment: Handle back button press, mungkin kembali ke screen sebelumnya ---
                          Navigator.of(context).pop();
                        },
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Order Detail',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Card Plastik
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/plastic-bottles.jpg', // Ganti dengan path gambar item plastik Anda
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Plastik',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons
                                            .delete_outline, // Sesuaikan dengan ikon di gambar
                                        color: Colors.green.shade700,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      const Text(
                                        '+900 Terbuang',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Berat Sampahmu?
                        const Text(
                          'Berat Sampahmu?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:
                              _weights.map((weight) {
                                bool isSelected = _selectedWeight == weight;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedWeight = weight;
                                      // --- Backend Comment: Update state berat terpilih, mungkin mempengaruhi harga ---
                                    });
                                  },
                                  child: Container(
                                    width: 55, // Lebar tombol berat
                                    height: 55, // Tinggi tombol berat
                                    decoration: BoxDecoration(
                                      color:
                                          isSelected
                                              ? Colors.green.shade600
                                              : Colors.green.shade400,
                                      shape: BoxShape.circle,
                                      boxShadow:
                                          isSelected
                                              ? [
                                                BoxShadow(
                                                  color: Colors.green.shade700
                                                      .withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 4,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ]
                                              : [],
                                    ),
                                    child: Center(
                                      child: Text(
                                        '$weight\nkg',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight:
                                              isSelected
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                        const SizedBox(height: 24),

                        // Foto Sampahmu
                        const Text(
                          'Foto Sampahmu',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {
                            // --- Backend Comment: Handle upload foto. Ini akan memanggil image picker ---
                            // print('Upload Foto Sampah tapped');
                            // Implement image picker functionality here
                          },
                          child: Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: Colors.grey.shade400,
                                width: 1.5,
                                // Implementasi dashed border bisa lebih kompleks,
                                // ini adalah solid border sebagai gantinya.
                                // Untuk dashed border, Anda mungkin perlu package 'dotted_border'
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.grey[600],
                                  size: 30,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Upload Foto Sampah',
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Waktu PickOff
                        const Text(
                          'Waktu PickOff',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: _waktuPenjemputanController,
                          labelText: 'Waktu Penjemputan', // Label sesuai gambar
                          hintText:
                              'Masukkan Tanggal Penjemputan dd/mm/yyyy', // Hint sesuai gambar
                          // suffixIcon: Icons.calendar_today,
                          onTapIcon:
                              () => _selectDate(
                                context,
                                _waktuPenjemputanController,
                              ), // Seharusnya ini untuk tanggal
                          // Jika label "Waktu Penjemputan" benar-benar untuk input waktu:
                          // onTapIcon: () => _selectTime(context, _waktuPenjemputanController),
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: _tanggalPenjemputanController,
                          labelText:
                              'Tanggal Penjemputan', // Label sesuai gambar
                          hintText:
                              'Masukkan Waktu Penjemputan dd/mm/yyyy', // Hint sesuai gambar (sepertinya ada kekeliruan di gambar)
                          // Seharusnya format waktu seperti HH:mm
                          // suffixIcon: Icons.access_time,
                          onTapIcon:
                              () => _selectTime(
                                context,
                                _tanggalPenjemputanController,
                              ), // Seharusnya ini untuk waktu
                          // Jika label "Tanggal Penjemputan" benar-benar untuk input tanggal:
                          // onTapIcon: () => _selectDate(context, _tanggalPenjemputanController),
                        ),
                        const SizedBox(height: 24),

                        // Informasi Penjemputan
                        const Text(
                          'Informasi Penjemputan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: _noTelpController,
                          hintText: 'Masukkan No.Telp',
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: _alamatLengkapController,
                          hintText: 'Masukkan Alamat Lengkap',
                          maxLines: 3,
                        ),
                        const SizedBox(height: 24),

                        // Details
                        const Text(
                          'Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildDetailRow(
                          'Waktu Penjemputan',
                          _detailWaktuPenjemputan,
                        ),
                        _buildDetailRow(
                          'Tanggal Penjemputan',
                          _detailTanggalPenjemputan,
                        ),
                        _buildDetailRow(
                          'Pajak 11%',
                          _formatCurrency(pajakAmount),
                        ),
                        const Divider(height: 20, thickness: 1),
                        _buildDetailRow(
                          'Total',
                          _formatCurrency(totalAmount),
                          isTotal: true,
                        ),

                        const SizedBox(height: 80), // Space for bottom button
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Button
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
                  // Opsional, jika ingin ada border radius di atas
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  // --- Backend Comment: Proses Order. Kumpulkan semua data: ---
                  // String? selectedWeight = _selectedWeight;
                  // String waktuPenjemputan = _waktuPenjemputanController.text;
                  // String tanggalPenjemputan = _tanggalPenjemputanController.text;
                  // String noTelp = _noTelpController.text;
                  // String alamat = _alamatLengkapController.text;
                  // File? fotoSampah; // Jika sudah diimplementasikan
                  // --- Backend Comment: Kirim data ini ke API atau service backend ---
                  // print('Proses Order Tapped');
                  // print('Berat: $selectedWeight, Waktu: $waktuPenjemputan, Tanggal: $tanggalPenjemputan, Telp: $noTelp, Alamat: $alamat');
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
                  minimumSize: const Size(double.infinity, 50), // Full width
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

  Widget _buildTextField({
    required TextEditingController controller,
    String? labelText, // Label di atas input field
    required String hintText,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    IconData? suffixIcon,
    VoidCallback? onTapIcon,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(
            labelText,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
        ],
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          readOnly:
              readOnly ||
              (onTapIcon !=
                  null), // ReadOnly jika ada onTapIcon (untuk date/time picker)
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey.shade500),
            filled: true,
            fillColor: Colors.white, // Warna background field input
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.green.shade400, width: 1.5),
            ),
            suffixIcon:
                suffixIcon != null
                    ? IconButton(
                      icon: Icon(suffixIcon, color: Colors.grey.shade600),
                      onPressed: onTapIcon,
                    )
                    : null,
          ),
          onTap: onTapIcon != null && !readOnly ? onTapIcon : null,
          // --- Backend Comment: Validasi input bisa ditambahkan di sini ---
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return 'Field ini tidak boleh kosong';
          //   }
          //   return null;
          // },
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black87 : Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Clipper untuk background atas (mirip screen sebelumnya)
class CurvedHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40); // Sesuaikan tinggi lekukan jika perlu
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 25.0);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    var secondControlPoint = Offset(
      size.width - (size.width / 3.25),
      size.height - 55,
    );
    var secondEndPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
