import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/Entities/user_entity.dart';
import 'package:flight_booking_app/domain/repositories/auth_repository.dart';

class GetCurrentUserUsecase {
  final AuthRepository _authRepository;

  GetCurrentUserUsecase(this._authRepository);

  Future<Either<Exception, UserEntity?>> call() async {
    return await _authRepository.getCurrentUser();
  }
}
