import 'dart:convert';
import 'package:flight_booking_app/data/models/user.dart';
import 'package:flight_booking_app/domain/entities/user_entity.dart';

class UserMapper {
  static UserEntity fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json["id"] as int,
      accessToken: json["accessToken"] as String,
      name: json["name"] as String,
      email: json["email"] as String,
      phone: json["phone"] as String,
      country: json["country"] as String,
      city: json["city"] as String,
      avatar: json["avatar"] as String?,
      password: json["password"] as String,
    );
  }

  static Map<String, dynamic> toJson(UserEntity user) {
    return {
      "id": user.id,
      "accessToken": user.accessToken,
      "name": user.name,
      "email": user.email,
      "phone": user.phone,
      "country": user.country,
      "city": user.city,
      "avatar": user.avatar,
      "password": user.password,
    };
  }

  static UserEntity fromJsonString(String jsonString) {
    return fromJson(jsonDecode(jsonString));
  }

  static String toJsonString(UserEntity user) {
    return jsonEncode(toJson(user));
  }

  static List<UserEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => fromJson(json)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<UserEntity> users) {
    return users.map((user) => toJson(user)).toList();
  }

  static UserEntity fromModel(UserModel model) {
    return UserEntity(
      id: model.id,
      accessToken: model.accessToken,
      name: model.name,
      email: model.email,
      phone: model.phone,
      country: model.country,
      city: model.city,
      password: model.password,
    );
  }
}
