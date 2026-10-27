class CourierModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String status;
  final String vehicleType;
  final String plateNumber;

  CourierModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.status,
    required this.vehicleType,
    required this.plateNumber,
  });

  factory CourierModel.fromJson(Map<String, dynamic> json) {
    return CourierModel(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      status: json['status'] ?? 'active',
      vehicleType: json['vehicle_type'] ?? '',
      plateNumber: json['plate_number'] ?? '',
    );
  }
}
