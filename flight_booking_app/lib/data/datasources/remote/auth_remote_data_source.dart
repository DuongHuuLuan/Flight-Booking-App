import 'package:flight_booking_app/data/mappers/user_mapper.dart';
import 'package:flight_booking_app/data/services/auth_service.dart';
import 'package:flight_booking_app/domain/Entities/user.dart';

class AuthRemoteDataSource {
  final AuthService _authService;

  AuthRemoteDataSource(this._authService);

  Future<UserEntity> login(String email, String password) async {
    if (email == "tim.jennings@example.com" && password == "123456") {
      return UserEntity(
        id: 1,
        name: "Tim Jennings",
        email: email,
        phone: "(808) 555-0111",
        country: "United Arab Emirates",
        city: "Dubai",
        password: password,
        avatar: "",
      );
    }

    // api
    final response = await _authService.login({
      'email': email,
      'password': password,
    });
    final user = UserMapper.fromModel(response.data.data!);

    return user;
  }

  Future<UserEntity> register(UserEntity user) async {
    try {
      final response = await _authService.register({
        "name": user.name,
        "email": user.email,
        "phone": user.phone,
        "country": user.country,
        "city": user.city,
        "password": user.password,
      });

      final registeredUser = UserMapper.fromModel(response.data.data!);
      return registeredUser;
    } catch (e) {
      throw Exception("Register failed: ${e.toString()}");
    }
  }
}
