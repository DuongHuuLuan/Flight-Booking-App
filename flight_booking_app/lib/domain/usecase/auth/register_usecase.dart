import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/entities/user_entity.dart';
import 'package:flight_booking_app/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository _repository;
  RegisterUsecase(this._repository);

  Future<Either<Exception, UserEntity>> call(UserEntity user) async {
    return await _repository.register(user);
  }
}
