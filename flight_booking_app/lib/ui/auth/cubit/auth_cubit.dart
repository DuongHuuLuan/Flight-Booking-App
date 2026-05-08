import 'package:flight_booking_app/domain/models/user.dart';
import 'package:flight_booking_app/domain/usecase/getProfileUsecase.dart';
import 'package:flight_booking_app/domain/usecase/loginUsecase.dart';
import 'package:flight_booking_app/domain/usecase/logoutUsecase.dart';
import 'package:flight_booking_app/domain/usecase/registerUsecase.dart';
import 'package:flight_booking_app/ui/auth/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final LogoutUsecase logoutUsecase;
  final GetProfileUsecase getProfileUsecase;

  AuthCubit({
    required this.loginUsecase,
    required this.registerUsecase,
    required this.logoutUsecase,
    required this.getProfileUsecase,
  }) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      await loginUsecase(email, password);
      await getProfile();
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  Future<void> register(UserModel user) async {
    emit(AuthLoading());
    try {
      await registerUsecase(user);
      await getProfile();
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await logoutUsecase();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  Future<void> getProfile() async {
    try {
      final user = await getProfileUsecase();
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    await getProfile();
  }
}
