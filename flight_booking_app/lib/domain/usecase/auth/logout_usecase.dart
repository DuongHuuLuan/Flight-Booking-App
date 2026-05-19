import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/repositories/auth_repository.dart';

class LogoutUsecase {
  final AuthRepository _repository;
  LogoutUsecase(this._repository);

  Future<Either<Exception, Unit>> call() async {
    return await _repository.logOut();
  }
}
