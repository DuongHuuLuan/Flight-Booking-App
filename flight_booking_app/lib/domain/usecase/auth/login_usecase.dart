import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/Entities/user_entity.dart';
import 'package:flight_booking_app/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository _repository;
  LoginUsecase(this._repository);

  Future<Either<Exception, UserEntity>> call(
    String email,
    String password,
  ) async {
    return await _repository.login(email, password);
  }
}
