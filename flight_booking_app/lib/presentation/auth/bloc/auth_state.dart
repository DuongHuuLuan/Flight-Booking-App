import 'package:equatable/equatable.dart';
import 'package:flight_booking_app/domain/entities/user_entity.dart';

enum AuthStatus { initial, authAuthenticated, authUnauthenticated }

class AuthState extends Equatable {
  final bool isLoading;
  final AuthStatus status;
  final UserEntity? user;
  final String? errorMessage;
  final String? successMessage;
  final String? nextStep;

  const AuthState({
    this.status = AuthStatus.initial,
    this.isLoading = false,
    this.user,
    this.errorMessage,
    this.nextStep,
    this.successMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    bool? isLoading,
    UserEntity? user,
    String? errorMessage,
    String? successMessage,
    String? nextStep,
  }) => AuthState(
    status: status ?? this.status,
    isLoading: isLoading ?? this.isLoading,
    user: user ?? this.user,
    errorMessage: errorMessage,
    successMessage: successMessage,
    nextStep: nextStep ?? this.nextStep,
  );

  @override
  List<Object?> get props => [
    status,
    isLoading,
    user,
    errorMessage,
    successMessage,
    nextStep,
  ];
}
