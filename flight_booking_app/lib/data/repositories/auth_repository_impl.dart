import 'package:flight_booking_app/data/mock/mock_user_data.dart';
import 'package:flight_booking_app/domain/models/user.dart';
import 'package:flight_booking_app/domain/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  static const String _userKey = "current_user";

  @override
  Future<void> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    if (email == userData.email && password == userData.password) {
      await prefs.setString(_userKey, email);
    } else {
      throw Exception("Invalid email or password");
    }
  }

  @override
  Future<void> register(
    String name,
    String email,
    String password,
    String phone,
    String country,
    String city,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final newUser = UserModel(
      id: DateTime.now().microsecondsSinceEpoch,
      name: name,
      password: password,
      phone: phone,
      country: country,
      city: city,
      email: email,
    );

    await prefs.setString('user_$email', newUser.toJsonString());
    await prefs.setString(_userKey, email);
  }

  @override
  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  @override
  Future<UserModel> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString(_userKey);

    if (email == null) {
      throw Exception("User not logged in");
    }

    if (email == userData.email) {
      return userData;
    }

    final userJson = prefs.getString('$_userKey$email');
    if (userJson != null) {
      return UserModel.fromJsonString(userJson);
    }

    throw Exception("User not found");
  }
}
