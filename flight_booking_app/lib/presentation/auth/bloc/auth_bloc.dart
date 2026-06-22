import 'package:flight_booking_app/data/datasources/local/auth_local_data_source.dart';
import 'package:flight_booking_app/domain/usecase/auth/forgot_password_with_email_usecase.dart';
import 'package:flight_booking_app/domain/usecase/auth/forgot_password_with_sms_usecase.dart';
import 'package:flight_booking_app/domain/usecase/auth/get_current_user_usecase.dart';
import 'package:flight_booking_app/domain/usecase/auth/login_usecase.dart';
import 'package:flight_booking_app/domain/usecase/auth/logout_usecase.dart';
import 'package:flight_booking_app/domain/usecase/auth/register_usecase.dart';
import 'package:flight_booking_app/domain/usecase/auth/reset_password_by_email_usecase.dart';
import 'package:flight_booking_app/domain/usecase/auth/reset_password_by_sms_usecase.dart';
import 'package:flight_booking_app/domain/usecase/auth/verify_otp_usecase.dart';
import 'package:flight_booking_app/presentation/auth/bloc/auth_event.dart';
import 'package:flight_booking_app/presentation/auth/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
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

  AuthBloc({
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
  }) : super(const AuthState()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<GetUserEvent>(_onGetUser);
    on<LogoutEvent>(_onLogout);
    on<ForgotPasswordSMSEvent>(_onForgotPasswordSMS);
    on<ForgotPasswordEmailEvent>(_onForgotPasswordEmail);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<ResetPasswordEvent>(_onResetPassword);
  }

  String _parseError(dynamic exception) {
    final message = exception.toString().toLowerCase();
    if (message.contains('network') || message.contains('SocketException')) {
      return 'Network error.';
    }
    if (message.contains('timeout')) {
      return 'Connection timed out. Please try again.';
    }
    if (message.contains('401') || message.contains('credential')) {
      return 'Incorrect email or password.';
    }
    if (message.contains('409') || message.contains('already exists')) {
      return 'Email has been used.';
    }
    if (message.contains('400')) {
      return 'Invalid data.';
    }
    return message.replaceAll("Exception:", "");
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await loginUsecase(event.email, event.password);
    await result.fold(
      (e) async {
        emit(
          state.copyWith(
            isLoading: false,
            status: AuthStatus.authUnauthenticated,
            errorMessage: _parseError(e),
          ),
        );
      },
      (user) async {
        if (user.accessToken == null || user.refresh_token == null) {
          emit(
            state.copyWith(
              isLoading: false,
              status: AuthStatus.authUnauthenticated,
              errorMessage: 'Invalid credentials from server.',
            ),
          );
          return;
        }
        try {
          await localStorage.saveUser(user);
          await localStorage.saveToken(user.accessToken!);
          await localStorage.saveRefreshToken(user.refresh_token!);
        } catch (e) {
          emit(
            state.copyWith(
              isLoading: false,
              status: AuthStatus.authUnauthenticated,
              errorMessage: 'Failed to save session.',
            ),
          );
          return;
        }
        emit(
          state.copyWith(
            isLoading: false,
            status: AuthStatus.authAuthenticated,
            user: user,
            errorMessage: null,
          ),
        );
      },
    );
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await registerUsecase(event.user);
    await result.fold(
      (e) async {
        emit(
          state.copyWith(
            isLoading: false,
            status: AuthStatus.authUnauthenticated,
            errorMessage: _parseError(e),
          ),
        );
      },
      (user) async {
        if (user.accessToken == null || user.refresh_token == null) {
          emit(
            state.copyWith(
              isLoading: false,
              status: AuthStatus.authUnauthenticated,
              errorMessage: 'Invalid credentials from server.',
            ),
          );
          return;
        }
        try {
          await localStorage.saveToken(user.accessToken!);
          await localStorage.saveRefreshToken(user.refresh_token!);
          await localStorage.saveUser(user);
        } catch (e) {
          emit(
            state.copyWith(
              isLoading: false,
              status: AuthStatus.authUnauthenticated,
              errorMessage: 'Failed to save session.',
            ),
          );
          return;
        }
        emit(
          state.copyWith(
            isLoading: false,
            status: AuthStatus.authAuthenticated,
            user: user,
            errorMessage: null,
          ),
        );
      },
    );
  }

  Future<void> _onGetUser(GetUserEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await getCurrentUserUsecase();
    await result.fold(
      (_) async {
        emit(
          state.copyWith(
            isLoading: false,
            status: AuthStatus.authUnauthenticated,
            user: null,
          ),
        );
      },
      (user) async {
        if (user == null) {
          emit(
            state.copyWith(
              isLoading: false,
              status: AuthStatus.authUnauthenticated,
              user: null,
            ),
          );
        } else {
          emit(
            state.copyWith(
              isLoading: false,
              status: AuthStatus.authAuthenticated,
              user: user,
            ),
          );
        }
      },
    );
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await logoutUsecase();

    await result.fold(
      (e) async {
        emit(state.copyWith(isLoading: false, errorMessage: _parseError(e)));
      },
      (_) async {
        emit(
          state.copyWith(
            isLoading: false,
            status: AuthStatus.authUnauthenticated,
            user: null,
            errorMessage: null,
          ),
        );
      },
    );
  }

  Future<void> _onForgotPasswordSMS(
    ForgotPasswordSMSEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await forgotPasswordWithSmsUsecase(event.phone);
    await result.fold(
      (e) async {
        emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      },
      (r) async {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: null,
            successMessage: r.message,
            nextStep: r.nextStep,
          ),
        );
      },
    );
  }

  Future<void> _onForgotPasswordEmail(
    ForgotPasswordEmailEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await forgotPasswordWithEmailUsecase(event.email);
    await result.fold(
      (e) async {
        emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      },
      (r) async {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: null,
            successMessage: r.message,
            nextStep: r.nextStep,
          ),
        );
      },
    );
  }

  Future<void> _onVerifyOtp(
    VerifyOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await verifyOtpUsecase(
      email: event.email,
      phone: event.phone,
      otp: event.otp,
    );
    await result.fold(
      (e) async {
        emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      },
      (r) async {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: null,
            successMessage: r.message,
          ),
        );
      },
    );
  }

  Future<void> _onResetPassword(
    ResetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = event.email != null
        ? await resetPasswordByEmailUsecase(event.email!, event.newPassword)
        : await resetPasswordBySmsUsecase(event.phone!, event.newPassword);
    await result.fold(
      (e) async {
        emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      },
      (r) async {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: null,
            successMessage: r.message,
          ),
        );
      },
    );
  }
}
