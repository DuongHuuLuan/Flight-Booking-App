import 'package:flight_booking_app/domain/entities/seat_entity.dart';

class SelectSeatState {
  final bool isLoading;
  final List<SeatEntity> seats;
  final String? selectedSeat;
  final bool isBooking;
  final String? bookingId;
  final double basePrice;
  final String? error;

  SelectSeatState({
    this.isLoading = false,
    this.seats = const [],
    this.selectedSeat,
    this.isBooking = false,
    this.bookingId,
    this.basePrice = 0,
    this.error,
  });

  SelectSeatState copyWith({
    bool? isLoading,
    List<SeatEntity>? seats,
    String? selectedSeat,
    bool? isBooking,
    String? bookingId,
    double? basePrice,
    String? error,
  }) {
    return SelectSeatState(
      isLoading: isLoading ?? this.isLoading,
      seats: seats ?? this.seats,
      selectedSeat: selectedSeat ?? this.selectedSeat,
      isBooking: isBooking ?? this.isBooking,
      bookingId: bookingId ?? this.bookingId,
      basePrice: basePrice ?? this.basePrice,
      error: error,
    );
  }
}
