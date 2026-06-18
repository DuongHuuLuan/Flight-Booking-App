// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: (json['access_token'] as num).toInt(),
  accessToken: json['accessToken'] as String?,
  refreshToken: json['refresh_token'] as String?,
  name: json['name'] as String,
  email: json['email'] as String,
  password: json['password'] as String,
  city: json['city'] as String,
  country: json['country'] as String,
  phone: json['phone'] as String,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'access_token': instance.id,
  'accessToken': instance.accessToken,
  'refresh_token': instance.refreshToken,
  'name': instance.name,
  'email': instance.email,
  'password': instance.password,
  'phone': instance.phone,
  'country': instance.country,
  'city': instance.city,
};
