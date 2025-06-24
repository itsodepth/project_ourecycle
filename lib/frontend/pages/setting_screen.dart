// frontend/pages/setting_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ourecycle/backend/config/app_route.dart';
import 'package:project_ourecycle/backend/models/user_model.dart'; // <-- 1. Impor UserModel
import 'package:project_ourecycle/backend/services/session_service.dart'; // <-- 1. Impor SessionService
import 'package:project_ourecycle/frontend/pages/edit_profile_screen.dart';
import 'package:project_ourecycle/frontend/widgets/settings_item_widget.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  // <-- 2. Tambahkan state untuk nama dan email
  String _userName = 'Loading...';
  String _userEmail = 'Loading...';

  // <-- 3. Panggil fungsi load data saat halaman dibuka
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // <-- 4. Buat fungsi untuk mengambil data dari sesi
  Future<void> _loadUserData() async {
    UserModel? user = await SessionService.getUser();
    if (user != null) {
      setState(() {
        // Gunakan '??' untuk memberikan nilai default jika data ternyata null
        _userName = user.name ?? 'Nama Tidak Ditemukan';
        _userEmail = user.email ?? 'Email Tidak Ditemukan';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 40),
              child: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF079119),
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  const Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 50,
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        bottom: 1,
                        right: 5,
                        child: CircleAvatar(
                          backgroundColor: Color(0xff53f2f6),
                          radius: 15,
                          child: Icon(Icons.edit, size: 15),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // <-- 5. Ganti teks statis dengan variabel state
                  Text(
                    _userName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _userEmail,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => const EditProfileScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF079119),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SettingsItemWidget(
                    icon: Icons.lock,
                    title: 'Ganti Password',
                    onTap: () {},
                  ),
                  SettingsItemWidget(
                    icon: Icons.language,
                    title: 'Bahasa',
                    onTap: () {},
                  ),
                  SettingsItemWidget(
                    icon: Icons.logout,
                    title: 'Logout',
                    iconColor: Colors.red,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder:
                            (_) => AlertDialog(
                              title: const Text('Konfirmasi Logout'),
                              content: const Text(
                                'Apakah Anda yakin ingin keluar?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Batal'),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  onPressed: () async {
                                    await SessionService.clearUser();
                                    Get.offAllNamed(AppRoute.login.name);
                                  },
                                  child: const Text(
                                    'Logout',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
