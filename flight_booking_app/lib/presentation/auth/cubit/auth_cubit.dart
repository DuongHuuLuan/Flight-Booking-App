import 'package:flight_booking_app/domain/Entities/user.dart';
import 'package:flight_booking_app/domain/usecase/login_usecase.dart';
import 'package:flight_booking_app/domain/usecase/logout_usecase.dart';
import 'package:flight_booking_app/domain/usecase/register_usecase.dart';
import 'package:flight_booking_app/presentation/auth/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final LogoutUsecase logoutUsecase;

  AuthCubit({
    required this.loginUsecase,
    required this.registerUsecase,
    required this.logoutUsecase,
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
}
