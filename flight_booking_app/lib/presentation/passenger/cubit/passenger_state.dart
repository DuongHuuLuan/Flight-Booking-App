import 'package:flight_booking_app/domain/entities/passenger_entity.dart';

class PassengerState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final List<PassengerEntity>? passengers;

  const PassengerState({
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
    this.passengers,
  });

  PassengerState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    List<PassengerEntity>? passengers,
  }) {
    return PassengerState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
      passengers: passengers ?? this.passengers,
    );
  }
}
