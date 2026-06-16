import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: "access_token")
  final int id;
  final String? accessToken;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String country;
  final String city;

  UserModel({
    required this.id,
    this.accessToken,
    required this.name,
    required this.email,
    required this.password,
    required this.city,
    required this.country,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  void operator [](String other) {}
}
