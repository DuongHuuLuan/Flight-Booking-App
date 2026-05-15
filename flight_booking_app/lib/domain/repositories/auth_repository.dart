import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/Entities/auth/forgot_password_result.dart';
import 'package:flight_booking_app/domain/Entities/auth/reset_password_result.dart';
import 'package:flight_booking_app/domain/Entities/auth/verify_otp_result.dart';
import 'package:flight_booking_app/domain/Entities/user.dart';

abstract class AuthRepository {
  Future<Either<Exception, UserEntity>> login(String email, String password);
  Future<Either<Exception, UserEntity>> register(UserEntity user);
  Future<Either<Exception, Unit>> logOut();
  Future<Either<Exception, ForgotPasswordResult>> forgotPasswordWithSMS(
    String phone,
  );
  Future<Either<Exception, ForgotPasswordResult>> forgotPasswordWithEmail(
    String email,
  );
  Future<Either<Exception, VerifyOtpResult>> verifyOtp({
    String? email,
    String? phone,
    required String otp,
  });
  Future<Either<Exception, ResetPasswordResult>> resetPasswordBySMS(
    String phone,
    String newPassword,
  );
  Future<Either<Exception, ResetPasswordResult>> resetPasswordByEmail(
    String email,
    String newPassword,
  );
}
