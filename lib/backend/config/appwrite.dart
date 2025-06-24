import 'package:appwrite/appwrite.dart';

class Appwrite {
  static const String projectId = '6840105000091811278f';
  static const String endpoint = 'https://fra.cloud.appwrite.io/v1';
  static const String databaseId = '68401bfc00213d197a44';
  static const String collectionUsers = '68401df60036ed17d597';
  static const String collectionWasteCategories = '68428f750022dc4cab85';
  static const String collectionOrders = '684299fb003e5f6116a4'; 
  static const String collectionDropOffLocations = '6842b7d3003807bc398f';
  // Perbaikan 1: Mengganti nama variabel agar konsisten (plural)
  static const String bucketWasteCategories = '684291ee00064c3a5b27';
  // 6842b7d3003807bc398f
  static Client client = Client();
  static late Account account;
  static late Databases databases;
  static late Storage storage;

  static void init() {
    client
        .setEndpoint(endpoint)
        .setProject(projectId);

    account = Account(client);
    databases = Databases(client);
    storage = Storage(client);
  }

  static String getImageUrl(String fileId) {
    if (fileId.isEmpty) return '';
    // Perbaikan 2: Menggunakan nama variabel yang benar
    return '$endpoint/storage/buckets/$bucketWasteCategories/files/$fileId/view?project=$projectId';
  }
  
  // Perbaikan 3: URL di bawah ini bukan kode Dart yang valid dan sudah dihapus.
}