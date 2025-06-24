// backend/models/dropoff_location_model.dart
class DropOffLocationModel {
  final String id;
  final String name;
  final String address;
  final String? operatingHours;

  DropOffLocationModel({
    required this.id,
    required this.name,
    required this.address,
    this.operatingHours,
  });

  factory DropOffLocationModel.fromJson(Map<String, dynamic> json) {
    return DropOffLocationModel(
      id: json['\$id'],
      name: json['name'],
      address: json['address'],
      operatingHours: json['operatingHours'],
    );
  }
}