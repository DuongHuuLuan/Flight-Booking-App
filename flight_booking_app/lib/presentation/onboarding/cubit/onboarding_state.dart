import 'package:equatable/equatable.dart';
import 'package:flight_booking_app/domain/entities/onboarding_entity.dart';

class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

class OnboardingInitial extends OnboardingState {}

class OnboardingLoading extends OnboardingState {}

class OnboardingLoaded extends OnboardingState {
  final List<OnboardingEntity> data;

  const OnboardingLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

//trạng thái xảy ra lỗi
class OnboardingError extends OnboardingState {
  final String message;

  const OnboardingError(this.message);

  @override
  List<Object?> get props => [message];
}
