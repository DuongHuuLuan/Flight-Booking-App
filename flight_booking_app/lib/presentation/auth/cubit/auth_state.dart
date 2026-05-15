import 'package:equatable/equatable.dart';
import 'package:flight_booking_app/domain/Entities/user.dart';

class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserEntity user;

  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

class AuthFailed extends AuthState {
  final String error;

  const AuthFailed(this.error);

  @override
  List<Object?> get props => [error];
}

//Forgot Password
class ForgotPasswordLoading extends AuthState {}

class ForgotPasswordSuccess extends AuthState {
  final String message;
  final String? nextStep;

  const ForgotPasswordSuccess(this.message, this.nextStep);

  @override
  List<Object?> get props => [message, nextStep];
}

class ForgotPasswordFailure extends AuthState {
  final String error;
  const ForgotPasswordFailure(this.error);

  @override
  List<Object?> get props => [error];
}

//Verfify
class VerifyOtpLoading extends AuthState {}

class VerifyOtpSuccess extends AuthState {
  final String message;
  const VerifyOtpSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class VerifyOtpFailure extends AuthState {
  final String error;
  const VerifyOtpFailure(this.error);

  @override
  List<Object?> get props => [error];
}

//Reset Pasword
class ResetPasswordLoading extends AuthState {}

class ResetPasswordSuccess extends AuthState {
  final String message;
  const ResetPasswordSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ResetPasswordFailure extends AuthState {
  final String error;
  const ResetPasswordFailure(this.error);
}
