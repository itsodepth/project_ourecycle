// frontend/pages/register_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Impor GetX
import 'package:project_ourecycle/backend/controllers/register_controller.dart'; // Impor controller kita
import 'package:project_ourecycle/frontend/widgets/text_field_register.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Inisialisasi controller menggunakan GetX
  final controller = Get.put(RegisterController());
  bool _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
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
                Image.asset('assets/ourecycle-logo.png', height: 100),
                const SizedBox(height: 20),
                const Text('Silakan buat akun dahulu', textAlign: TextAlign.center),
                const SizedBox(height: 30),

                TextFieldRegister(
                  controller: controller.nameController, // Hubungkan controller
                  hintText: 'Nama Lengkap',
                  prefixIcon: Icons.person_outline,
                ),
                const SizedBox(height: 16),

                TextFieldRegister(
                  controller: controller.emailController, // Hubungkan controller
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                ),
                const SizedBox(height: 16),

                TextFieldRegister(
                  controller: controller.phoneController, // Hubungkan controller
                  hintText: 'Nomor Telepon',
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone_outlined,
                ),
                const SizedBox(height: 16),

                TextFieldRegister(
                  controller: controller.addressController, // Hubungkan controller
                  hintText: 'Alamat',
                  prefixIcon: Icons.home_outlined,
                ),
                const SizedBox(height: 16),

                TextFieldRegister(
                  controller: controller.passwordController, // Hubungkan controller
                  hintText: 'Password',
                  obscureText: _obscurePassword,
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                const SizedBox(height: 30),

                // Dengarkan perubahan pada isLoading menggunakan Obx
                Obx(() {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.isLoading
                          ? null // Nonaktifkan tombol saat loading
                          : () => controller.execute(context), // Panggil fungsi execute dari controller
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: controller.isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                            )
                          : const Text(
                              'Daftar',
                              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                    ),
                  );
                }),
                
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Sudah punya akun? '),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Text('Masuk disini', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}