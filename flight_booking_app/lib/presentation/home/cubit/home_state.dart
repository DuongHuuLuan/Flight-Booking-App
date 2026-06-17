import 'package:equatable/equatable.dart';
import 'package:flight_booking_app/domain/entities/flight.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<FlightEntity> popular;
  final String? errorMessage;
  const HomeState({
    this.status = HomeStatus.initial,
    this.popular = const [],
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<FlightEntity>? popular,
    String? errorMessage,
  }) => HomeState(
    status: status ?? this.status,
    popular: popular ?? this.popular,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [status, popular, errorMessage];
}
