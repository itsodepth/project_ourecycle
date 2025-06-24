// main.dart (Versi Final)

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_ourecycle/backend/config/app_route.dart'; // <-- 1. Impor Rute
import 'package:project_ourecycle/backend/services/session_service.dart'; // <-- 2. Impor Session Service
import 'package:project_ourecycle/frontend/pages/animated_navbar.dart';
import 'package:project_ourecycle/frontend/pages/edit_profile_screen.dart';
import 'package:project_ourecycle/frontend/pages/login_screen.dart';
import 'package:project_ourecycle/frontend/pages/register_screen.dart';

import 'package:project_ourecycle/backend/config/appwrite.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Appwrite.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
      logWriterCallback: (String text, {bool isError = false}) {
        print("GETX LOG: $text");
      },

      // <-- 3. Gunakan initialRoute, kita mulai dari 'splash' untuk pengecekan
      initialRoute: AppRoute.splash.name,

      // <-- 4. Definisikan semua halaman di sini
      routes: {
        // Rute 'splash' ini adalah gerbang utama aplikasi
        AppRoute.splash.name: (context) {
          return FutureBuilder(
            future: SessionService.getUser(), // Memeriksa sesi login
            builder: (context, snapshot) {
              // Saat sedang loading, tampilkan spinner
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              // Jika ada data (user sudah login), arahkan ke dashboard
              if (snapshot.hasData && snapshot.data != null) {
                return const AnimationBar(); // Halaman utama Anda
              }
              // Jika tidak ada data (user belum login), arahkan ke halaman login
              return const LoginScreen(); // Ubah disini untuk testing fitur (sementara)
            },
          );
        },
        // Definisikan rute lainnya
        AppRoute.login.name: (context) => const LoginScreen(),
        AppRoute.register.name: (context) => const RegisterScreen(),
        AppRoute.dashboard.name: (context) => const AnimationBar(),
      },
    );
  }
}
