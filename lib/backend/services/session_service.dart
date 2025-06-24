// backend/services/session_service.dart

import 'dart:convert';
import 'package:project_ourecycle/backend/config/appwrite.dart';
import 'package:project_ourecycle/backend/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  // Kunci untuk menyimpan data di SharedPreferences
  static const String _userSessionKey = 'user_session';

  // Menyimpan data UserModel ke local storage
  static Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    // Ubah objek UserModel menjadi string JSON untuk disimpan
    String userJson = jsonEncode(user.toJson());
    await prefs.setString(_userSessionKey, userJson);
  }

  // Mengambil data UserModel dari local storage
  static Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userJson = prefs.getString(_userSessionKey);

    // Print untuk tujuan debugging
    print('DEBUG [SessionService]: Membaca sesi. Data JSON: $userJson');

    if (userJson != null) {
      // Jika ada data, ubah kembali dari string JSON ke objek UserModel
      return UserModel.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  // Menghapus sesi (untuk logout)
  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    // Hapus data dari Appwrite
    try {
      await Appwrite.account.deleteSession(sessionId: 'current');
    } catch (e) {
      print("Gagal menghapus sesi di Appwrite: $e");
    }
    
    // Hapus data dari local storage
    await prefs.remove(_userSessionKey);
  }
}