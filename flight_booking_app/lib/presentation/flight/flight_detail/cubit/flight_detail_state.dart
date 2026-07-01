import 'package:flight_booking_app/domain/entities/flight_detail_entity.dart';

class FlightDetailState {
  final bool isLoading;
  final FlightDetailEntity? flightDetail;
  final bool isBooking;
  final String? bookingId;
  final String? error;

  FlightDetailState({
    this.isLoading = false,
    this.flightDetail,
    this.isBooking = false,
    this.bookingId,
    this.error,
  });

  FlightDetailState copyWith({
    bool? isLoading,
    FlightDetailEntity? flightDetail,
    bool? isBooking,
    String? bookingId,
    String? error,
  }) {
    return FlightDetailState(
      isLoading: isLoading ?? this.isLoading,
      flightDetail: flightDetail ?? this.flightDetail,
      isBooking: isBooking ?? this.isBooking,
      bookingId: bookingId ?? this.bookingId,
      error: error,
    );
  }
}
