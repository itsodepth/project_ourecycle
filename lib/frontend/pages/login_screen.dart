// frontend/pages/login_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ourecycle/backend/config/app_route.dart';
import 'package:project_ourecycle/backend/controllers/login_controller.dart';
import 'package:project_ourecycle/frontend/widgets/text_field_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Inisialisasi controller menggunakan GetX
  final controller = Get.put(LoginController());
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
                Image.asset('assets/ourecycle-logo.png', height: 120),
                const SizedBox(height: 24),
                const Text('Welcome to OuRecycle', style: TextStyle(fontSize: 24, color: Colors.green, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Masuk untuk melanjutkan', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                const SizedBox(height: 32),

                TextFieldLogin(
                  controller: controller.emailController, // Hubungkan controller
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                ),
                const SizedBox(height: 16),

                TextFieldLogin(
                  controller: controller.passwordController, // Hubungkan controller
                  hintText: 'Password',
                  obscureText: _obscurePassword,
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                const SizedBox(height: 24),

                Obx(() {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.isLoading ? null : () => controller.execute(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: controller.isLoading
                          ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3))
                          : const Text('Login', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  );
                }),
                
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Belum punya akun? '),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoute.register.name), // Navigasi ke halaman register
                      child: const Text('Daftar disini', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}