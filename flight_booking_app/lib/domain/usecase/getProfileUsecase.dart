import 'package:flight_booking_app/domain/models/user.dart';
import 'package:flight_booking_app/domain/repositories/auth_repository.dart';

class GetProfileUsecase {
  final AuthRepository _repository;

  GetProfileUsecase(this._repository);

  Future<UserModel> call() {
    return _repository.getProfile();
  }
}
