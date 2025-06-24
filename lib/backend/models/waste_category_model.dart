// backend/models/waste_category_model.dart

class WasteCategoryModel {
  final String id;
  final String name;
  final String? info;
  final String? imageId;
  // Tambahkan field yang hilang
  final double? pricePerKg;
  final double? minWeight;

  WasteCategoryModel({
    required this.id,
    required this.name,
    this.info,
    this.imageId,
    this.pricePerKg,
    this.minWeight,
  });

  factory WasteCategoryModel.fromJson(Map<String, dynamic> json) {
    return WasteCategoryModel(
      id: json['\$id'],
      name: json['name'],
      info: json['info'],
      imageId: json['imageId'],
      // Tambahkan parsing untuk field yang baru
      pricePerKg: (json['pricePerKg'] ?? 0.0).toDouble(),
      minWeight: (json['minWeight'] ?? 0.0).toDouble(),
    );
  }
}