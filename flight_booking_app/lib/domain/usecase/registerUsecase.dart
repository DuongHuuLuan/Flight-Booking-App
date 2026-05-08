import 'package:flight_booking_app/domain/models/user.dart';
import 'package:flight_booking_app/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository _repository;
  RegisterUsecase(this._repository);

  Future<void> call(UserModel user) async {
    if (user.email.isEmpty || user.password.isEmpty) {
      throw Exception("Email and password cannot be empty");
    }
    await _repository.register(
      user.name,
      user.email,
      user.password,
      user.phone,
      user.country,
      user.city,
    );
  }
}
