import 'package:equatable/equatable.dart';
import 'package:flight_booking_app/domain/models/onboarding.dart';

class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

//trạng thái khởi tạo
class OnboardingInitial extends OnboardingState {}

//trạng thái đang tải dữ liệu
class OnboardingLoading extends OnboardingState {}

//trạn thái đã tải dữ liệu thành công
class OnboardingLoaded extends OnboardingState {
  final List<OnboardingModel> data;

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
