import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/entities/auth/verify_otp_result.dart';
import 'package:flight_booking_app/domain/repositories/auth_repository.dart';

class VerifyOtpUsecase {
  final AuthRepository _authRepository;

  VerifyOtpUsecase(this._authRepository);

  Future<Either<Exception, VerifyOtpResult>> call({
    String? email,
    String? phone,
    required String otp,
  }) async {
    return _authRepository.verifyOtp(email: email, phone: phone, otp: otp);
  }
}
