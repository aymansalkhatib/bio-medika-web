class UserModel {
  final String id;
  final String name;
  final String email;
  final String pharmacy;
  final String phone;
  final String city;
  final String landmark;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.pharmacy,
    required this.phone,
    required this.city,
    required this.landmark,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      name: json['name'],
      email: json['email'],
      pharmacy: json['pharmacy_name'],
      phone: json['phone_number'],
      city: json['city'],
      landmark: json['landmark'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'pharmacy_name': pharmacy,
      'phone_number': pharmacy,
      'city': pharmacy,
      'landmark': pharmacy,
    };
  }
}
