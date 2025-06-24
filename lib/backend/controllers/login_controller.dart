// backend/controllers/login_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ourecycle/backend/config/app_route.dart';
import 'package:project_ourecycle/backend/datasources/user_datasource.dart';
import 'package:project_ourecycle/backend/services/session_service.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  void execute(BuildContext context) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('Email dan password wajib diisi'),
      ));
      return;
    }

    _isLoading.value = true;

    final result = await UserDatasource.signIn(
      email: emailController.text,
      password: passwordController.text,
    );

    _isLoading.value = false;

    result.fold(
      (errorMessage) {
        // Gagal, tampilkan pesan error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(errorMessage),
        ));
      },
      (userModel) async {
        // =================== PRINT UNTUK DEBUGGING ===================
        // Baris ini akan mencetak data user yang berhasil didapat ke console.
        print('DEBUG: Login berhasil! Data yang akan disimpan: ${userModel.toJson()}');
        // ===============================================================

        // Sukses, simpan data user ke sesi
        await SessionService.saveUser(userModel);

        // Arahkan ke dashboard dan hapus semua halaman sebelumnya
        Get.offAllNamed(AppRoute.dashboard.name);
      },
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}