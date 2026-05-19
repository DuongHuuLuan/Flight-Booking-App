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
    emit(state.copywith(status: AuthStatus.loading));
    final failureOrSuccess = await loginUsecase(email, password);

    failureOrSuccess.fold(
      (exception) {
        final message = exception.toString().toLowerCase();
        if (message.contains('network') ||
            message.contains('SocketException')) {
          emit(
            state.copywith(
              status: AuthStatus.failed,
              errorMessage: "network error.",
            ),
          );
        } else if (message.contains('timeout.')) {
          emit(
            state.copywith(
              status: AuthStatus.failed,
              errorMessage: "Connection timed out. Please try again.",
            ),
          );
        } else if (message.contains('401') || message.contains('credential')) {
          emit(
            state.copywith(
              status: AuthStatus.failed,
              errorMessage: "Incorrect email or password.",
            ),
          );
        } else if (message.contains('400')) {
          emit(
            state.copywith(
              status: AuthStatus.failed,
              errorMessage: "Invalid data.",
            ),
          );
        } else {
          emit(
            state.copywith(
              status: AuthStatus.failed,
              errorMessage: "Error: ${message.replaceAll("Exception:", "")}",
            ),
          );
        }
      },
      (user) async {
        await localStorage.saveToken(user.password);
        await localStorage.saveUser(user);
        emit(state.copywith(status: AuthStatus.authAuthenticated, user: user));
      },
    );
  }

  Future<void> register(UserEntity user) async {
    emit(state.copywith(status: AuthStatus.loading));
    final failureOrSuccess = await registerUsecase(user);

    failureOrSuccess.fold(
      (exception) {
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
      },
      (user) => emit(
        state.copywith(status: AuthStatus.authAuthenticated, user: user),
      ),
    );
  }

  Future<void> getUser() async {
    final failureOrSusscess = await getCurrentUserUsecase();

    failureOrSusscess.fold(
      (exception) =>
          emit(state.copywith(status: AuthStatus.authUnauthenticated)),
      (user) => emit(
        state.copywith(status: AuthStatus.authAuthenticated, user: user),
      ),
    );
  }

  Future<void> logout() async {
    emit(state.copywith(status: AuthStatus.loading));
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
    }, (r) => emit(state.copywith(status: AuthStatus.authUnauthenticated)));
  }

  Future<void> forgotPasswordWithSMS(String phone) async {
    emit(state.copywith(status: AuthStatus.forgotPasswordLoading));
    final failureOrSuccess = await forgotPasswordWithSmsUsecase(phone);

    failureOrSuccess.fold(
      (exception) => emit(ForgotPasswordFailure(exception.toString())),
      (result) => emit(
        state.copywith(
          status: AuthStatus.forgotPasswordSuccess,
          successMessage: result.message,
          nextStep: result.nextStep,
        ),
      ),
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
    emit(state.copywith(status: AuthStatus.resetPasswordLoading));

    final result = email != null
        ? await resetPasswordByEmailUsecase(email, newPassword)
        : await resetPasswordBySmsUsecase(phone!, newPassword);

    result.fold(
      (exception) => emit(
        state.copywith(
          status: AuthStatus.resetPasswordFailure,
          errorMessage: exception.toString(),
        ),
      ),
      (result) => emit(
        state.copywith(
          status: AuthStatus.resetPasswordSuccess,
          successMessage: result.message,
        ),
      ),
    );
  }
}
