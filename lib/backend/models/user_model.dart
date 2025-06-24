// backend/models/user_model.dart

class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? address;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
  });

  // Factory constructor untuk membuat instance UserModel dari Map (JSON)
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['\$id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        address: json['address'],
      );

  // Method untuk mengubah instance UserModel menjadi Map (JSON)
  Map<String, dynamic> toJson() => {
        // ==== PERBAIKAN UTAMA DI SINI ====
        // Sekarang kita juga menyimpan ID ke dalam JSON
        '\$id': id, 
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
      };
}