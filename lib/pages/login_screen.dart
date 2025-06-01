import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ourecycle/pages/animated_navbar.dart';
import 'package:project_ourecycle/pages/register_screen.dart';
import 'package:project_ourecycle/widgets/text_field_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Warna latar belakang
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Aplikasi
                Image.asset('assets/ourecycle-logo.png', height: 120),
                const SizedBox(height: 24),

                const Text(
                  'Welcome to OuRecycle',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Masuk untuk melanjutkan',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                const SizedBox(height: 32),

                // TextField Email menggunakan widget kustom TextFieldLogin
                TextFieldLogin(
                  controller: _emailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                ),
                const SizedBox(height: 16),

                // TextField Password menggunakan widget kustom TextFieldLogin
                TextFieldLogin(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: _obscurePassword,
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey[600],
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                const SizedBox(height: 8),

                // Lupa Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      print('Tombol Lupa Password ditekan (Frontend)');
                      // TODO: Implementasi navigasi atau dialog Lupa Password
                    },
                    child: const Text(
                      'Lupa Password?',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Tombol Login
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      print('Tombol Login ditekan (Frontend)');
                      print('Email: $email');
                      print(
                        'Password (disembunyikan): ${'*' * password.length}',
                      );

                      if (email.isEmpty || password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Email dan Password tidak boleh kosong! (Frontend)',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }
                      Get.off(() => AnimationBar());

                      // TODO: Implementasi navigasi setelah login berhasil (misal ke halaman utama)
                      // Contoh: Get.offAll(() => HomeScreen());
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text(
                      //       'Login berhasil untuk $email (Simulasi Frontend)',
                      //     ),
                      //     backgroundColor: Colors.green,
                      //   ),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Pembatas "atau masuk dengan"
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade400)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'atau masuk dengan',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade400)),
                  ],
                ),
                const SizedBox(height: 20),

                // Tombol Login Google
                InkWell(
                  onTap: () {
                    print('Tombol Google Sign-In Ditekan (Frontend)!');
                    // TODO: Implementasi frontend untuk Google Sign-In
                  },
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/google-logo.png', // PERHATIKAN: Pastikan path aset ini benar
                      // Sebelumnya Anda menggunakan 'assets/images/google-logo.png'
                      // Sesuaikan dengan struktur folder Anda.
                      height: 28,
                      width: 28,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Link ke Halaman Daftar
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Belum punya akun? ',
                      style: TextStyle(fontSize: 15, color: Colors.black87),
                    ),
                    GestureDetector(
                      onTap: () {
                        print('Navigasi ke halaman Daftar (Frontend)');
                        Get.to(
                          () => const RegisterScreen(),
                        ); // Menggunakan GetX untuk navigasi
                      },
                      child: const Text(
                        'Daftar disini',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.green,
                        ),
                      ),
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
