import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ourecycle/pages/order_screen.dart';
import 'package:project_ourecycle/pages/setting_screen.dart';
import 'package:project_ourecycle/pages/transaksi_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Data untuk GridView
  final List<Map<String, dynamic>> gridItems = [
    {
      'nama': 'Kertas',
      'icon': Icons.recycling,
      'info': '+900 Terbuang',
      'color': Color(0xFF079119),
      'imagePath': 'assets/ourecycle.png',
    },
    {
      'nama': 'Plastik',
      'icon': Icons.recycling,
      'info': '+900 Terbuang',
      'color': Color(0xFF079119),
      'imagePath': 'assets/ourecycle.png',
    },
    {
      'nama': 'Kaca',
      'icon': Icons.recycling,
      'info': '+900 Terbuang',
      'color': Color(0xFF079119),
      'imagePath': 'assets/ourecycle.png',
    },
    {
      'nama': 'Organik',
      'icon': Icons.recycling,
      'info': '+900 Terbuang',
      'color': Color(0xFF079119),
      'imagePath': 'assets/ourecycle.png',
    },
    {
      'nama': 'Logam',
      'icon': Icons.recycling,
      'info': '+750 Terbuang',
      'color': Color(0xFF079119),
      'imagePath': 'assets/ourecycle.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: Text(
                'Home',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF079119),
                ),
                textAlign: TextAlign.left,
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Text(
                'Selamat Datang, User!', // <- Ganti pake nama pengguna yg login (BACK END)
                style: TextStyle(fontSize: 18, color: Color(0xFF079119)),
                textAlign: TextAlign.left,
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF079119),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // untuk ganti posisi bayangan
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/ourecycle.png',
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Informasi Terkini',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Berita terbaru tentang daur ulang dan lingkungan.',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 0.75, // rasio lebar:tinggi item
                  ),
                  itemCount: gridItems.length,
                  itemBuilder: (context, index) {
                    final item = gridItems[index];
                    return GestureDetector(
                      onTap: () {
                        // Aksi ketika item ditekan
                        // Ganti dengan navigasi ke halaman yang sesuai
                        String name = item['nama'];
                        if (name == 'Kertas') {
                          Get.to(() => OrderScreen());
                        } else if (name == 'Plastik') {
                          Get.to(() => OrderScreen());
                        } else if (name == 'Kaca') {
                          Get.to(() => OrderScreen());
                        } else if (name == 'Organik') {
                          Get.to(() => OrderScreen());
                        } else if (name == 'Logam') {
                          Get.to(() => OrderScreen());
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.1),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    item['imagePath'],
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 8.0),

                              Text(
                                item['nama'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[800],
                                ),
                              ),

                              const SizedBox(height: 8.0),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    item['icon'],
                                    color: item['color'],
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      item['info'],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
