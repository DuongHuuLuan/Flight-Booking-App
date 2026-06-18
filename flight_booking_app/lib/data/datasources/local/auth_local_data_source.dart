import 'package:flight_booking_app/data/mappers/user_mapper.dart';
import 'package:flight_booking_app/domain/entities/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<void> saveUser(UserEntity user);
  Future<void> saveRefreshToken(String refreshToken);
  Future<String?> getRefreshToken();
  Future<String?> getToken();
  Future<UserEntity?> getUser();
  Future<void> clear();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl(this.sharedPreferences);

  static const String _tokenKey = "access_token";
  static const String _userKey = "current_user";
  static const String _refreshTokenKey = "refresh_token";

  @override
  Future<void> saveToken(String token) async {
    await sharedPreferences.setString(_tokenKey, token);
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    await sharedPreferences.setString(_refreshTokenKey, refreshToken);
  }

  @override
  Future<void> saveUser(UserEntity user) async {
    final userJson = UserMapper.toJsonString(user);
    await sharedPreferences.setString(_userKey, user.email);
    await sharedPreferences.setString('user_${user.email}', userJson);
  }

  @override
  Future<String?> getToken() async => sharedPreferences.getString(_tokenKey);

  @override
  Future<String?> getRefreshToken() async =>
      sharedPreferences.getString(_refreshTokenKey);

  @override
  Future<UserEntity?> getUser() async {
    final email = sharedPreferences.getString(_userKey);
    if (email == null) return null;

    final userJson = sharedPreferences.getString('user_$email');
    if (userJson != null) {
      return UserMapper.fromJsonString(userJson);
    }
    return null;
  }

  @override
  Future<void> clear() async {
    await sharedPreferences.remove(_tokenKey);
    await sharedPreferences.remove(_userKey);
    await sharedPreferences.remove(_refreshTokenKey);
  }
}
