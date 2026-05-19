import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/Entities/auth/reset_password_result.dart';
import 'package:flight_booking_app/domain/repositories/auth_repository.dart';

class ResetPasswordBySmsUsecase {
  final AuthRepository _authRepository;

  ResetPasswordBySmsUsecase(this._authRepository);

  Future<Either<Exception, ResetPasswordResult>> call(
    String phone,
    String newPassword,
  ) async {
    return await _authRepository.resetPasswordBySMS(phone, newPassword);
  }
}
