import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/Entities/auth/forgot_password_result.dart';
import 'package:flight_booking_app/domain/repositories/auth_repository.dart';

class ForgotPasswordWithEmailUsecase {
  final AuthRepository _authRepository;

  ForgotPasswordWithEmailUsecase(this._authRepository);

  Future<Either<Exception, ForgotPasswordResult>> call(String email) async {
    return await _authRepository.forgotPasswordWithEmail(email);
  }
}
