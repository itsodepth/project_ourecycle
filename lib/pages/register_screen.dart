import 'package:flutter/material.dart';
import 'package:project_ourecycle/widgets/text_field_register.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // bool _isLoading = false; // Dihapus karena terkait backend
  bool _obscurePassword = true;

  // final RegisterService _registerService = RegisterService(); // Dihapus karena backend

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    // Logika frontend, misalnya validasi input
    final String nama = _namaController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (nama.isEmpty || email.isEmpty || password.isEmpty) {
      // Tampilkan pesan error sederhana menggunakan SnackBar (contoh frontend)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua field wajib diisi! (Frontend)'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Simulasi proses pendaftaran berhasil di frontend
    print('Tombol Daftar Ditekan (Frontend)');
    print('Nama: $nama');
    print('Email: $email');
    print('Password (disembunyikan untuk keamanan): ${'*' * password.length}');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Pendaftaran $nama berhasil! (Simulasi Frontend)'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/ourecycle-logo.png',
                  height: 120,
                ), // Ukuran disesuaikan
                const SizedBox(height: 20),
                const Text(
                  'Welcome to OuRecycle',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8), // Jarak antar teks
                Text(
                  'Silakan buat akun dahulu',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                const SizedBox(height: 30),

                TextFieldRegister(
                  controller: _namaController,
                  hintText: 'Nama Lengkap', // Lebih deskriptif
                  prefixIcon: Icons.person_outline,
                  keyboardType: TextInputType.name, // Keyboard type yang sesuai
                ),
                const SizedBox(height: 16),

                TextFieldRegister(
                  controller: _emailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                ),
                const SizedBox(height: 16),

                TextFieldRegister(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: _obscurePassword,
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey[600], // Warna ikon konsisten
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        _handleSignUp, // Tidak lagi menggunakan _isLoading
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      // Langsung menampilkan teks 'Daftar'
                      'Daftar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade400)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'atau daftar dengan', // Diubah sedikit
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade400)),
                  ],
                ),
                const SizedBox(height: 25),

                InkWell(
                  onTap: () {
                    // Logika frontend untuk Google Sign-In
                    print("Tombol Google Sign-In Ditekan (Frontend)!");
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Fitur Google Sign-In belum diimplementasikan (Frontend)',
                        ),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(
                    50,
                  ), // Untuk efek ripple yang bulat
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(
                            0.08,
                          ), // Shadow lebih halus
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/google-logo.png', // Pastikan path aset benar
                      height: 28,
                      width: 28,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sudah punya akun? ',
                      style: TextStyle(fontSize: 15, color: Colors.black87),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Logika frontend untuk kembali ke halaman login
                        print('Navigasi ke halaman Login (Frontend)');
                        Navigator.of(
                          context,
                        ).pop(); // Kembali ke halaman sebelumnya
                      },
                      child: const Text(
                        'Masuk disini',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 15, // Ukuran font disamakan
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.green, // Warna garis bawah
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30), // Padding bawah tambahan
              ],
            ),
          ),
        ),
      ),
    );
  }
}
