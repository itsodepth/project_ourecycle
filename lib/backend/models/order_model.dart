// backend/models/order_model.dart

class OrderModel {
  final String id;
  final String userId;
  final String? userName;
  final String wasteCategoryName;
  final double weight;
  final String orderType;
  final String address;
  final String phoneNumber;
  final DateTime scheduledAt;
  final double totalPrice;
  final double taxAmount;
  final String status;
  final String? photoId;

  OrderModel({
    required this.id,
    required this.userId,
    this.userName,
    required this.wasteCategoryName,
    required this.weight,
    required this.orderType,
    required this.address,
    required this.phoneNumber,
    required this.scheduledAt,
    required this.totalPrice,
    required this.taxAmount,
    required this.status,
    this.photoId,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['\$id'],
      userId: json['userId'],
      userName: json['userName'],
      wasteCategoryName: json['wasteCategoryName'],
      weight: (json['weight'] ?? 0.0).toDouble(),
      orderType: json['orderType'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      // Konversi string ISO 8601 dari Appwrite menjadi objek DateTime
      scheduledAt: DateTime.parse(json['scheduledAt']),
      totalPrice: (json['totalPrice'] ?? 0.0).toDouble(),
      taxAmount: (json['taxAmount'] ?? 0.0).toDouble(),
      status: json['status'],
      photoId: json['photoId'],
    );
  }
}