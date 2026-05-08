import 'dart:convert';

class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String country;
  final String city;
  final String? avatar;
  final String password;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.country,
    required this.city,
    this.avatar,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"] as int,
      name: json["name"] as String,
      email: json["email"] as String,
      phone: json["phone"] as String,
      country: json["country"] as String,
      city: json["city"] as String,
      avatar: json["avatar"] as String?,
      password: json["password"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phone": phone,
      "country": country,
      "city": city,
      "avatar": avatar,
      "password": password,
    };
  }

  String toJsonString() => jsonEncode(toJson());

  factory UserModel.fromJsonString(String jsonString) =>
      UserModel.fromJson(jsonDecode(jsonString));
}
