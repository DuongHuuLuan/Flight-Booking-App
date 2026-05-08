import 'package:flight_booking_app/domain/repositories/auth_repository.dart';

class LogoutUsecase {
  final AuthRepository _repository;
  LogoutUsecase(this._repository);

  Future<void> call() {
    return _repository.logOut();
  }
}
