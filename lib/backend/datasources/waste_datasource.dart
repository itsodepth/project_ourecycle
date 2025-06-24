// backend/datasources/waste_datasource.dart

import 'package:appwrite/appwrite.dart';
import 'package:project_ourecycle/backend/config/appwrite.dart';
import 'package:project_ourecycle/backend/models/waste_category_model.dart';

class WasteDatasource {
  static Future<List<WasteCategoryModel>> getWasteCategories() async {
    try {
      final result = await Appwrite.databases.listDocuments(
        databaseId: Appwrite.databaseId,
        collectionId: Appwrite.collectionWasteCategories,
      );

      // Ubah setiap dokumen menjadi WasteCategoryModel
      return result.documents
          .map((doc) => WasteCategoryModel.fromJson(doc.data))
          .toList();

    } on AppwriteException catch (e) {
      print("Error fetching waste categories: ${e.message}");
      return []; // Kembalikan list kosong jika error
    } catch (e) {
      print("Unknown error: $e");
      return [];
    }
  }
}