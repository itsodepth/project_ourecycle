// backend/controllers/register_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ourecycle/backend/datasources/user_datasource.dart';

class RegisterController extends GetxController {
  // Controllers untuk text fields
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();

  // State untuk loading
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  // Fungsi yang dipanggil dari UI
  void execute(BuildContext context) async {
    // Validasi
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        addressController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red, content: Text('Semua field wajib diisi')));
      return;
    }
    if (!GetUtils.isEmail(emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red, content: Text('Email tidak valid')));
      return;
    }
    if (passwordController.text.length < 8) {
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red, content: Text('Password minimal 8 karakter')));
      return;
    }

    _isLoading.value = true; // Mulai loading

    // Panggil datasource
    final result = await UserDatasource.signUp(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      phone: phoneController.text,
      address: addressController.text,
    );

    _isLoading.value = false; // Selesai loading

    result.fold(
      (errorMessage) {
        // Gagal, tampilkan pesan error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red, content: Text(errorMessage)));
      },
      (success) {
        // Sukses, tampilkan pesan berhasil dan kembali
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Pendaftaran berhasil! Silakan login.')));
        Navigator.of(context).pop();
      },
    );
  }

  @override
  void onClose() {
    // Membersihkan controller saat halaman ditutup
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}