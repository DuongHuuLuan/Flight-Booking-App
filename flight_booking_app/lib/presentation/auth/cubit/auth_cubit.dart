import 'package:flight_booking_app/domain/Entities/user.dart';
import 'package:flight_booking_app/domain/usecase/forgot_password_with_email_usecase.dart';
import 'package:flight_booking_app/domain/usecase/forgot_password_with_sms_usecase.dart';
import 'package:flight_booking_app/domain/usecase/login_usecase.dart';
import 'package:flight_booking_app/domain/usecase/logout_usecase.dart';
import 'package:flight_booking_app/domain/usecase/register_usecase.dart';
import 'package:flight_booking_app/domain/usecase/reset_password_by_email_usecase.dart';
import 'package:flight_booking_app/domain/usecase/reset_password_by_sms_usecase.dart';
import 'package:flight_booking_app/domain/usecase/verify_otp_usecase.dart';
import 'package:flight_booking_app/presentation/auth/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final LogoutUsecase logoutUsecase;
  final ForgotPasswordWithSmsUsecase forgotPasswordWithSmsUsecase;
  final ForgotPasswordWithEmailUsecase forgotPasswordWithEmailUsecase;
  final VerifyOtpUsecase verifyOtpUsecase;
  final ResetPasswordByEmailUsecase resetPasswordByEmailUsecase;
  final ResetPasswordBySmsUsecase resetPasswordBySmsUsecase;

  AuthCubit({
    required this.loginUsecase,
    required this.registerUsecase,
    required this.logoutUsecase,
    required this.forgotPasswordWithEmailUsecase,
    required this.forgotPasswordWithSmsUsecase,
    required this.resetPasswordByEmailUsecase,
    required this.resetPasswordBySmsUsecase,
    required this.verifyOtpUsecase,
  }) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final failureOrSuccess = await loginUsecase(email, password);

    failureOrSuccess.fold((exception) {
      final message = exception.toString().toLowerCase();
      if (message.contains('network') || message.contains('SocketException')) {
        emit(AuthFailed('network error.'));
      } else if (message.contains('timeout')) {
        emit(AuthFailed('Connection timed out. Please try again.'));
      } else if (message.contains('401') || message.contains('credential')) {
        emit(AuthFailed('Incorrect email or password.'));
      } else if (message.contains('400')) {
        emit(AuthFailed('Invalid data.'));
      } else {
        emit(AuthFailed('Error: ${message.replaceAll("Exception:", "")}'));
      }
    }, (user) => emit(AuthAuthenticated(user)));
  }

  Future<void> register(UserEntity user) async {
    emit(AuthLoading());
    final failureOrSuccess = await registerUsecase(user);

    failureOrSuccess.fold((exception) {
      final message = exception.toString().toLowerCase();
      if (message.contains('network')) {
        emit(AuthFailed('Network error.'));
      } else if (message.contains('409') ||
          message.contains('already exists')) {
        emit(AuthFailed('Email it has been used.'));
      } else if (message.contains('400')) {
        emit(AuthFailed('The registration data is invalid.'));
      } else {
        emit(
          AuthFailed(
            'Register failed: ${message.replaceAll("Exception:", "")}',
          ),
        );
      }
    }, (user) => emit(AuthAuthenticated(user)));
  }

  Future<void> logout() async {
    emit(AuthLoading());
    final failureOrSuccess = await logoutUsecase();

    failureOrSuccess.fold((exception) {
      final message = exception.toString().toLowerCase();
      if (message.contains('cache')) {
        emit(AuthFailed('Error deleting archived data.'));
      } else {
        emit(
          AuthFailed('Logout failed: ${message.replaceAll("Exception:", "")}'),
        );
      }
    }, (r) => emit(AuthUnauthenticated()));
  }

  Future<void> forgotPasswordWithSMS(String phone) async {
    emit(ForgotPasswordLoading());
    final failureOrSuccess = await forgotPasswordWithSmsUsecase(phone);

    failureOrSuccess.fold(
      (exception) => emit(ForgotPasswordFailure(exception.toString())),
      (result) => emit(ForgotPasswordSuccess(result.message, result.nextStep)),
    );
  }

  Future<void> forgotPasswordWithEmail(String email) async {
    emit(ForgotPasswordLoading());
    final result = await forgotPasswordWithEmailUsecase(email);

    result.fold(
      (exception) => emit(ForgotPasswordFailure(exception.toString())),
      (result) => emit(ForgotPasswordSuccess(result.message, result.nextStep)),
    );
  }

  Future<void> verifyOtpCode({
    String? email,
    String? phone,
    required String otp,
  }) async {
    emit(VerifyOtpLoading());
    final result = await verifyOtpUsecase(email: email, phone: phone, otp: otp);

    result.fold(
      (exception) => emit(VerifyOtpFailure(exception.toString())),
      (result) => emit(VerifyOtpSuccess(result.message)),
    );
  }

  Future<void> resetPassword({
    required String newPassword,
    String? email,
    String? phone,
  }) async {
    emit(ResetPasswordLoading());

    final result = email != null
        ? await resetPasswordByEmailUsecase(email, newPassword)
        : await resetPasswordBySmsUsecase(phone!, newPassword);

    result.fold(
      (exception) => emit(ResetPasswordFailure(exception.toString())),
      (result) => emit(ResetPasswordSuccess(result.message)),
    );
  }
}
