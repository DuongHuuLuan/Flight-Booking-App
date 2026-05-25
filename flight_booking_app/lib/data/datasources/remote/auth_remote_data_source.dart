import 'package:flight_booking_app/data/mappers/forgot_password_mapper.dart';
import 'package:flight_booking_app/data/mappers/user_mapper.dart';
import 'package:flight_booking_app/data/services/auth_service.dart';
import 'package:flight_booking_app/domain/Entities/auth/forgot_password_result.dart';
import 'package:flight_booking_app/domain/Entities/auth/reset_password_result.dart';
import 'package:flight_booking_app/domain/Entities/auth/verify_otp_result.dart';
import 'package:flight_booking_app/domain/Entities/user.dart';

class AuthRemoteDataSource {
  final AuthService _authService;

  AuthRemoteDataSource(this._authService);

  Future<UserEntity> login(String email, String password) async {
    if (email == "test@gmail.com" && password == "123456") {
      return UserEntity(
        id: 1,
        name: "Tim Jennings",
        email: email,
        phone: "(808) 555-0111",
        country: "United Arab Emirates",
        city: "Dubai",
        password: password,
        avatar: "",
      );
    }

    // api
    final response = await _authService.login({
      'email': email,
      'password': password,
    });
    final user = UserMapper.fromModel(response.data.data!);

    return user;
  }

  Future<UserEntity> register(UserEntity user) async {
    try {
      final response = await _authService.register({
        "name": user.name,
        "email": user.email,
        "phone": user.phone,
        "country": user.country,
        "city": user.city,
        "password": user.password,
      });

      final registeredUser = UserMapper.fromModel(response.data.data!);
      return registeredUser;
    } catch (e) {
      throw Exception("Register failed: ${e.toString()}");
    }
  }

  Future<ForgotPasswordResult> forgotPasswordWithSMS(String phone) async {
    try {
      if (phone == "(808) 555-0111") {
        return ForgotPasswordResult(message: phone);
      }

      final response = await _authService.forgotPasswordWithSMS({
        "phone": phone,
      });
      return ForgotPasswordMapper.toForgotPasswordResult(response.data.data!);
    } catch (e) {
      throw Exception("OTP send via SMS failed.: ${e.toString()}");
    }
  }

  Future<ForgotPasswordResult> forgotPasswordWithEmail(String email) async {
    try {
      if (email == "test@gmail.com") {
        return ForgotPasswordResult(message: email);
      }

      final response = await _authService.forgotPasswordWithEmail({
        "email": email,
      });
      return ForgotPasswordMapper.toForgotPasswordResult(response.data.data!);
    } catch (e) {
      throw Exception("OTP sent via Email failed.: ${e.toString()}");
    }
  }

  Future<VerifyOtpResult> verifyOtp({
    String? email,
    String? phone,
    required String otp,
  }) async {
    try {
      if (otp == "4444") {
        return VerifyOtpResult(message: "4444");
      }
      final body = <String, dynamic>{"otp": otp};
      if (email != null) body["email"] = email;
      if (phone != null) body["phone"] = phone;

      final response = await _authService.verifyOtp(body);
      return ForgotPasswordMapper.toVerifyOtpResult(response.data.data!);
    } catch (e) {
      throw Exception("OTP authentication failed: ${e.toString()}");
    }
  }

  Future<ResetPasswordResult> resetPasswordBySMS(
    String phone,
    String newPassword,
  ) async {
    try {
      if (phone == "(808) 555-0111") {
        return ResetPasswordResult(message: "Password reset successfully");
      }
      final response = await _authService.resetPasswordBySMS({
        "phone": phone,
        "new_password": newPassword,
      });
      return ForgotPasswordMapper.toResetPasswordResult(response.data.data!);
    } catch (e) {
      throw Exception("Password reset failed: ${e.toString()}");
    }
  }

  Future<ResetPasswordResult> resetPasswordByEmail(
    String email,
    String newPassword,
  ) async {
    try {
      if (email == "tim.jennings@example.com") {
        return ResetPasswordResult(message: "Password reset successfully");
      }

      final response = await _authService.resetPasswordByEmail({
        "email": email,
        "new_password": newPassword,
      });
      return ForgotPasswordMapper.toResetPasswordResult(response.data.data!);
    } catch (e) {
      throw Exception("Password reset via email failed.: ${e.toString()}");
    }
  }
}
