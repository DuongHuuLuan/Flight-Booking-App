class UserModel {
  final int id;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String country;
  final String city;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.city,
    required this.country,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      password: json["password"],
      city: json["city"],
      country: json["country"],
      phone: json["phone"],
    );
  }
}
