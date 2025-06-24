import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_ourecycle/backend/config/appwrite.dart';
import 'package:project_ourecycle/backend/datasources/waste_datasource.dart';
import 'package:project_ourecycle/backend/models/user_model.dart';
import 'package:project_ourecycle/backend/models/waste_category_model.dart';
import 'package:project_ourecycle/backend/services/session_service.dart';
import 'package:project_ourecycle/frontend/pages/order_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _userName = 'User';
  List<WasteCategoryModel> _wasteCategories = [];
  bool _isLoadingCategories = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadWasteCategories();
  }

  Future<void> _loadUserData() async {
    UserModel? user = await SessionService.getUser();
    if (user != null && mounted) {
      setState(() {
        _userName = user.name ?? 'User';
      });
    }
  }

  Future<void> _loadWasteCategories() async {
    setState(() => _isLoadingCategories = true);
    var categories = await WasteDatasource.getWasteCategories();
    if (mounted) {
      setState(() {
        _wasteCategories = categories;
        _isLoadingCategories = false;
      });
    }
  }

  IconData _getIconForCategory(String? categoryName) {
    switch (categoryName?.toLowerCase()) {
      case 'plastik': return Icons.local_drink;
      case 'kertas': return Icons.article;
      case 'kaca': return Icons.wine_bar;
      case 'logam': return Icons.build;
      default: return Icons.recycling;
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
              padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: Text('Home', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF079119))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Text('Selamat Datang, $_userName!', style: const TextStyle(fontSize: 18, color: Color(0xFF079119))),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF079119),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 2, blurRadius: 5, offset: const Offset(0, 3))],
              ),
              child: Row(
                children: [
                  ClipRRect(borderRadius: BorderRadius.circular(8.0), child: Image.asset('assets/ourecycle.png', height: 100, fit: BoxFit.cover)),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Informasi Terkini', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                        SizedBox(height: 10),
                        Text('Berita terbaru tentang daur ulang dan lingkungan.', style: TextStyle(fontSize: 16, color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _isLoadingCategories
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.all(16),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, crossAxisSpacing: 16.0, mainAxisSpacing: 16.0, childAspectRatio: 0.75,
                        ),
                        itemCount: _wasteCategories.length,
                        itemBuilder: (context, index) {
                          final category = _wasteCategories[index];
                          return GestureDetector(
                            // ================== PERUBAHAN DI SINI ==================
                            onTap: () => Get.to(() => OrderScreen(category: category)),
                            // =======================================================
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 4, offset: const Offset(0, 2))],
                                border: Border.all(color: Colors.grey.withOpacity(0.1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: (category.imageId != null && category.imageId!.isNotEmpty)
                                            ? Image.network(
                                                Appwrite.getImageUrl(category.imageId!),
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                loadingBuilder: (context, child, progress) => progress == null ? child : const Center(child: CircularProgressIndicator()),
                                                errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, color: Colors.grey, size: 40),
                                              )
                                            : Image.asset("assets/ourecycle.png", fit: BoxFit.cover, width: double.infinity),
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(category.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[800])),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        Icon(_getIconForCategory(category.name), color: const Color(0xFF079119), size: 16),
                                        const SizedBox(width: 4),
                                        Expanded(child: Text(category.info ?? '', style: TextStyle(fontSize: 12, color: Colors.grey[700]))),
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