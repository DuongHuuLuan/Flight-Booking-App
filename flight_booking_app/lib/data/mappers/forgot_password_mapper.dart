import 'package:flight_booking_app/data/models/forgot_password_response.dart';
import 'package:flight_booking_app/data/models/reset_password_response.dart';
import 'package:flight_booking_app/data/models/verify_otp_response.dart';
import 'package:flight_booking_app/domain/Entities/auth/forgot_password_result.dart';
import 'package:flight_booking_app/domain/Entities/auth/reset_password_result.dart';
import 'package:flight_booking_app/domain/Entities/auth/verify_otp_result.dart';

class ForgotPasswordMapper {
  static ForgotPasswordResult toForgotPasswordResult(
    ForgotPasswordResponse response,
  ) {
    return ForgotPasswordResult(
      message: response.message,
      nextStep: response.nextStep,
      contact: response.contact,
    );
  }

  static VerifyOtpResult toVerifyOtpResult(VerifyOtpResponse response) {
    return VerifyOtpResult(message: response.message);
  }

  static ResetPasswordResult toResetPasswordResult(
    ResetPasswordResponse response,
  ) {
    return ResetPasswordResult(message: response.message, success: true);
  }
}
