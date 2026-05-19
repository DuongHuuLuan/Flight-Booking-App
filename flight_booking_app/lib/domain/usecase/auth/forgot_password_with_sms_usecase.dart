import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/Entities/auth/forgot_password_result.dart';
import 'package:flight_booking_app/domain/repositories/auth_repository.dart';

class ForgotPasswordWithSmsUsecase {
  final AuthRepository _authRepository;

  ForgotPasswordWithSmsUsecase(this._authRepository);

  Future<Either<Exception, ForgotPasswordResult>> call(String phone) async {
    return await _authRepository.forgotPasswordWithSMS(phone);
  }
}
