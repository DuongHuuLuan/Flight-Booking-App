import 'package:flight_booking_app/domain/models/user.dart';

abstract class AuthRepository {
  Future<void> login(String email, String password);
  Future<void> register(
    String name,
    String email,
    String password,
    String phone,
    String country,
    String city,
  );
  Future<void> logOut();
  Future<UserModel> getProfile();
}
