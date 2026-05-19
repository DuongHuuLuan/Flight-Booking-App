import 'package:flight_booking_app/data/datasources/local/auth_local_data_source.dart';
import 'package:flight_booking_app/domain/Entities/user.dart';
import 'package:flight_booking_app/domain/usecase/auth/forgot_password_with_email_usecase.dart';
import 'package:flight_booking_app/domain/usecase/auth/forgot_password_with_sms_usecase.dart';
import 'package:flight_booking_app/domain/usecase/auth/get_current_user_usecase.dart';
import 'package:flight_booking_app/domain/usecase/auth/login_usecase.dart';
import 'package:flight_booking_app/domain/usecase/auth/logout_usecase.dart';
import 'package:flight_booking_app/domain/usecase/auth/register_usecase.dart';
import 'package:flight_booking_app/domain/usecase/auth/reset_password_by_email_usecase.dart';
import 'package:flight_booking_app/domain/usecase/auth/reset_password_by_sms_usecase.dart';
import 'package:flight_booking_app/domain/usecase/auth/verify_otp_usecase.dart';
import 'package:flight_booking_app/presentation/auth/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final LogoutUsecase logoutUsecase;
  final GetCurrentUserUsecase getCurrentUserUsecase;
  final AuthLocalDataSource localStorage;
  final ForgotPasswordWithSmsUsecase forgotPasswordWithSmsUsecase;
  final ForgotPasswordWithEmailUsecase forgotPasswordWithEmailUsecase;
  final VerifyOtpUsecase verifyOtpUsecase;
  final ResetPasswordByEmailUsecase resetPasswordByEmailUsecase;
  final ResetPasswordBySmsUsecase resetPasswordBySmsUsecase;

  AuthCubit({
    required this.loginUsecase,
    required this.registerUsecase,
    required this.logoutUsecase,
    required this.getCurrentUserUsecase,
    required this.forgotPasswordWithEmailUsecase,
    required this.forgotPasswordWithSmsUsecase,
    required this.resetPasswordByEmailUsecase,
    required this.resetPasswordBySmsUsecase,
    required this.verifyOtpUsecase,
    required this.localStorage,
  }) : super(const AuthState());

  Future<void> login(String email, String password) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final failureOrSuccess = await loginUsecase(email, password);

    failureOrSuccess.fold(
      (exception) {
        final message = exception.toString().toLowerCase();
        if (message.contains('network') ||
            message.contains('SocketException')) {
          emit(
            state.copyWith(
              status: AuthStatus.failed,
              errorMessage: "network error.",
            ),
          );
        } else if (message.contains('timeout.')) {
          emit(
            state.copyWith(
              status: AuthStatus.failed,
              errorMessage: "Connection timed out. Please try again.",
            ),
          );
        } else if (message.contains('401') || message.contains('credential')) {
          emit(
            state.copyWith(
              status: AuthStatus.failed,
              errorMessage: "Incorrect email or password.",
            ),
          );
        } else if (message.contains('400')) {
          emit(
            state.copyWith(
              status: AuthStatus.failed,
              errorMessage: "Invalid data.",
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: AuthStatus.failed,
              errorMessage: "Error: ${message.replaceAll("Exception:", "")}",
            ),
          );
        }
      },
      (user) async {
        await localStorage.saveToken(user.password);
        await localStorage.saveUser(user);
        emit(state.copyWith(status: AuthStatus.authAuthenticated, user: user));
      },
    );
  }

  Future<void> register(UserEntity user) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final failureOrSuccess = await registerUsecase(user);

    failureOrSuccess.fold(
      (exception) {
        final message = exception.toString().toLowerCase();
        if (message.contains('network')) {
          emit(state.copyWith(status: AuthStatus.failed, errorMessage: 'Network error.'));
        } else if (message.contains('409') ||
            message.contains('already exists')) {
          emit(state.copyWith(status: AuthStatus.failed, errorMessage: 'Email it has been used.'));
        } else if (message.contains('400')) {
          emit(state.copyWith(status: AuthStatus.failed, errorMessage: 'The registration data is invalid.'));
        } else {
          emit(
            state.copyWith(
              status: AuthStatus.failed,
              errorMessage: 'Register failed: ${message.replaceAll("Exception:", "")}',
            ),
          );
        }
      },
      (user) => emit(
        state.copyWith(status: AuthStatus.authAuthenticated, user: user),
      ),
    );
  }

  Future<void> getUser() async {
    final failureOrSusscess = await getCurrentUserUsecase();

    failureOrSusscess.fold(
      (exception) =>
          emit(state.copyWith(status: AuthStatus.authUnauthenticated)),
      (user) => emit(
        state.copyWith(status: AuthStatus.authAuthenticated, user: user),
      ),
    );
  }

  Future<void> logout() async {
    emit(state.copyWith(status: AuthStatus.loading));
    final failureOrSuccess = await logoutUsecase();

    failureOrSuccess.fold((exception) {
      final message = exception.toString().toLowerCase();
      if (message.contains('cache')) {
        emit(state.copyWith(status: AuthStatus.failed, errorMessage: 'Error deleting archived data.'));
      } else {
        emit(
          state.copyWith(status: AuthStatus.failed, errorMessage: 'Logout failed: ${message.replaceAll("Exception:", "")}'),
        );
      }
    }, (r) => emit(state.copyWith(status: AuthStatus.authUnauthenticated)));
  }

  Future<void> forgotPasswordWithSMS(String phone) async {
    emit(state.copyWith(status: AuthStatus.forgotPasswordLoading));
    final failureOrSuccess = await forgotPasswordWithSmsUsecase(phone);

    failureOrSuccess.fold(
      (exception) => emit(state.copyWith(status: AuthStatus.forgotPasswordFailure, errorMessage: exception.toString())),
      (result) => emit(
        state.copyWith(
          status: AuthStatus.forgotPasswordSuccess,
          successMessage: result.message,
          nextStep: result.nextStep,
        ),
      ),
    );
  }

  Future<void> forgotPasswordWithEmail(String email) async {
    emit(state.copyWith(status: AuthStatus.forgotPasswordLoading));
    final result = await forgotPasswordWithEmailUsecase(email);

    result.fold(
      (exception) => emit(state.copyWith(status: AuthStatus.forgotPasswordFailure, errorMessage: exception.toString())),
      (result) => emit(state.copyWith(status: AuthStatus.forgotPasswordSuccess, successMessage: result.message, nextStep: result.nextStep)),
    );
  }

  Future<void> verifyOtpCode({
    String? email,
    String? phone,
    required String otp,
  }) async {
    emit(state.copyWith(status: AuthStatus.verifyOtpLoading));
    final result = await verifyOtpUsecase(email: email, phone: phone, otp: otp);

    result.fold(
      (exception) => emit(state.copyWith(status: AuthStatus.verifyOtpFailure, errorMessage: exception.toString())),
      (result) => emit(state.copyWith(status: AuthStatus.verifyOtpSuccess, successMessage: result.message)),
    );
  }

  Future<void> resetPassword({
    required String newPassword,
    String? email,
    String? phone,
  }) async {
    emit(state.copyWith(status: AuthStatus.resetPasswordLoading));

    final result = email != null
        ? await resetPasswordByEmailUsecase(email, newPassword)
        : await resetPasswordBySmsUsecase(phone!, newPassword);

    result.fold(
      (exception) => emit(
        state.copyWith(
          status: AuthStatus.resetPasswordFailure,
          errorMessage: exception.toString(),
        ),
      ),
      (result) => emit(
        state.copyWith(
          status: AuthStatus.resetPasswordSuccess,
          successMessage: result.message,
        ),
      ),
    );
  }
}
