// backend/datasources/order_datasource.dart

import 'package:appwrite/appwrite.dart';
import 'package:dartz/dartz.dart';
import 'package:project_ourecycle/backend/config/appwrite.dart';
import 'package:project_ourecycle/backend/models/order_model.dart';   // <-- Impor OrderModel
import 'package:project_ourecycle/backend/models/user_model.dart';   // <-- Impor UserModel
import 'package:project_ourecycle/backend/services/session_service.dart'; // <-- Impor SessionService

class OrderDatasource {
  
  // Fungsi createOrder dari sebelumnya...
  static Future<Either<String, void>> createOrder({
    //... (isi fungsi ini tidak berubah)
    required String userId,
    required String userName,
    required String wasteCategoryName,
    required double weight,
    required String orderType,
    required String address,
    required String phoneNumber,
    required DateTime scheduledAt,
    required double totalPrice,
    required double taxAmount,
    String? photoId,
  }) async {
    try {
      final Map<String, dynamic> dataToSend = {
        'userId': userId, 'userName': userName, 'wasteCategoryName': wasteCategoryName,
        'weight': weight, 'orderType': orderType, 'address': address,
        'phoneNumber': phoneNumber, 'scheduledAt': scheduledAt.toIso8601String(),
        'totalPrice': totalPrice, 'taxAmount': taxAmount, 'status': 'in-progress',
        'photoId': photoId,
      };
      await Appwrite.databases.createDocument(
        databaseId: Appwrite.databaseId,
        collectionId: Appwrite.collectionOrders,
        documentId: ID.unique(),
        data: dataToSend,
      );
      return const Right(null);
    } on AppwriteException catch (e) {
      return Left(e.message ?? 'Terjadi kesalahan saat membuat pesanan.');
    } catch (e) {
      return Left('Terjadi kesalahan yang tidak diketahui: $e');
    }
  }


  // =================== FUNGSI BARU DI SINI ===================
  static Future<Either<String, List<OrderModel>>> getOrders() async {
    try {
      // 1. Dapatkan dulu ID pengguna yang sedang login
      UserModel? currentUser = await SessionService.getUser();
      if (currentUser == null || currentUser.id == null) {
        return const Left('Gagal mendapatkan data pengguna. Silakan login ulang.');
      }

      // 2. Ambil dokumen dari collection 'Orders'
      final result = await Appwrite.databases.listDocuments(
        databaseId: Appwrite.databaseId,
        collectionId: Appwrite.collectionOrders,
        // 3. Gunakan Query untuk memfilter: hanya ambil pesanan dengan userId yang cocok
        queries: [
          Query.equal('userId', [currentUser.id!])
        ],
      );

      // 4. Ubah setiap dokumen menjadi objek OrderModel dan kembalikan sebagai list
      List<OrderModel> orders = result.documents
          .map((doc) => OrderModel.fromJson(doc.data))
          .toList();
      
      return Right(orders);

    } on AppwriteException catch (e) {
      return Left(e.message ?? 'Gagal mengambil riwayat pesanan.');
    } catch (e) {
      return Left('Terjadi kesalahan tidak diketahui: $e');
    }
  }
}