import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/Entities/auth/reset_password_result.dart';
import 'package:flight_booking_app/domain/repositories/auth_repository.dart';

class ResetPasswordByEmailUsecase {
  final AuthRepository _authRepository;

  ResetPasswordByEmailUsecase(this._authRepository);

  Future<Either<Exception, ResetPasswordResult>> call(
    String email,
    String newPassword,
  ) async {
    return await _authRepository.resetPasswordByEmail(email, newPassword);
  }
}
