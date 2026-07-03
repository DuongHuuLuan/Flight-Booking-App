import 'package:flight_booking_app/domain/entities/user_entity.dart';

sealed class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email, password;
  LoginEvent(this.email, this.password);
}

class RegisterEvent extends AuthEvent {
  final UserEntity user;
  RegisterEvent(this.user);
}

class RegisterRawEvent extends AuthEvent {
  final String name, email, phone, country, city, password, confirmPassword;
  RegisterRawEvent({
    required this.name,
    required this.email,
    required this.phone,
    required this.country,
    required this.city,
    required this.password,
    required this.confirmPassword,
  });
}

class GetUserEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

sealed class ForgotPasswordEvent extends AuthEvent {}

class ForgotPasswordSMSEvent extends ForgotPasswordEvent {
  final String phone;
  ForgotPasswordSMSEvent(this.phone);
}

class ForgotPasswordEmailEvent extends ForgotPasswordEvent {
  final String email;
  ForgotPasswordEmailEvent(this.email);
}

class ForgotPasswordRawEvent extends AuthEvent {
  final String? phone;
  final String? email;
  ForgotPasswordRawEvent({this.phone, this.email});
}

class VerifyOtpEvent extends ForgotPasswordEvent {
  final String otp;
  final String? email;
  final String? phone;
  VerifyOtpEvent({required this.otp, this.email, this.phone});
}

class ResetPasswordEvent extends ForgotPasswordEvent {
  final String newPassword;
  final String confirmPassword;
  final String? email;
  final String? phone;
  ResetPasswordEvent({
    required this.newPassword,
    this.confirmPassword = '',
    this.email,
    this.phone,
  });
}
