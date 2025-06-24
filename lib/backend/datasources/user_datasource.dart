// backend/datasources/user_datasource.dart

import 'package:appwrite/appwrite.dart';
import 'package:dartz/dartz.dart';
import 'package:project_ourecycle/backend/config/appwrite.dart';
import 'package:project_ourecycle/backend/models/user_model.dart';

class UserDatasource {
  // --- SIGN UP ---
  static Future<Either<String, UserModel>> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String address,
  }) async {
    try {
      final user = await Appwrite.account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );

      final document = await Appwrite.databases.createDocument(
        databaseId: Appwrite.databaseId,
        collectionId: Appwrite.collectionUsers,
        documentId: user.$id,
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'address': address,
        },
      );

      // === PERBAIKAN DI SINI ===
      // Tambahkan $id ke dalam map sebelum di-parse
      final data = document.data;
      data['\$id'] = document.$id;
      return Right(UserModel.fromJson(data));

    } on AppwriteException catch (e) {
      // ... (error handling tidak berubah)
      String message = 'Terjadi kesalahan, silakan coba lagi.';
      if (e.type == 'user_already_exists' || e.code == 409) {
        message = 'Email sudah terdaftar.';
      } else {
        message = e.message ?? message;
      }
      return Left(message);
    } catch (e) {
      return Left('Terjadi kesalahan yang tidak diketahui: $e');
    }
  }

  // --- SIGN IN ---
  static Future<Either<String, UserModel>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final session = await Appwrite.account.createEmailPasswordSession(
        email: email,
        password: password,
      );

      final document = await Appwrite.databases.getDocument(
        databaseId: Appwrite.databaseId,
        collectionId: Appwrite.collectionUsers,
        documentId: session.userId,
      );
      
      // === PERBAIKAN DI SINI ===
      // Tambahkan $id ke dalam map sebelum di-parse
      final data = document.data;
      data['\$id'] = document.$id;
      return Right(UserModel.fromJson(data));

    } on AppwriteException catch (e) {
      // ... (error handling tidak berubah)
      String message = 'Terjadi kesalahan, silakan coba lagi.';
      if (e.type == 'user_invalid_credentials' || e.code == 401) {
        message = 'Email atau password salah.';
      } else {
        message = e.message ?? message;
      }
      return Left(message);
    } catch (e) {
      return Left('Terjadi kesalahan yang tidak diketahui: $e');
    }
  }
}