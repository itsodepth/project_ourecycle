// setting_screen.dart
import 'package:flutter/material.dart';
import 'package:project_ourecycle/widgets/settings_item_widget.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
              child: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF079119),
                ),
                textAlign: TextAlign.left,
              ),
            ),

            Center(
              child: Column(
                children: [
                  Stack(
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

                  Text(
                    'Maria Antoinette',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    'antoinette@gmail.com',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      // Aksi untuk mengedit profil
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF079119),
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

                  Divider(
                    color: Colors.grey.withOpacity(0.5),
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
                    onTap: () {
                      // Navigasi ke halaman ganti password
                    },
                  ),
                  SettingsItemWidget(
                    icon: Icons.language,
                    title: 'Bahasa',
                    onTap: () {
                      // Pilihan bahasa
                    },
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
                                  onPressed: () {
                                    // Proses logout
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Logout'),
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
