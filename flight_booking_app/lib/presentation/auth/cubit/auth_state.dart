import 'package:equatable/equatable.dart';
import 'package:flight_booking_app/domain/Entities/user_entity.dart';

enum AuthStatus {
  initial,
  loading,
  authAuthenticated,
  authUnauthenticated,
  failed,

  forgotPasswordLoading,
  forgotPasswordSuccess,
  forgotPasswordFailure,

  verifyOtpLoading,
  verifyOtpSuccess,
  verifyOtpFailure,

  resetPasswordLoading,
  resetPasswordSuccess,
  resetPasswordFailure,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final UserEntity? user;
  final String? errorMessage;
  final String? successMessage;
  final String? nextStep;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorMessage,
    this.nextStep,
    this.successMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    UserEntity? user,
    String? errorMessage,
    String? successMessage,
    String? nextStep,
  }) => AuthState(
    status: status ?? this.status,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage,
    successMessage: successMessage ?? this.successMessage,
    nextStep: nextStep ?? this.nextStep,
  );

  @override
  List<Object?> get props => [status, user, errorMessage, successMessage, nextStep];
}
