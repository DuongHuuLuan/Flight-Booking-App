import 'package:flight_booking_app/domain/entities/seat/seat_entity.dart';

class SelectSeatState {
  final bool isLoading;
  final List<SeatEntity> seats;
  final List<String> selectedSeats;
  final bool isBooking;
  final String? bookingId;
  final double basePrice;
  final String? error;

  double get totalPrice => basePrice * selectedSeats.length;

  SelectSeatState({
    this.isLoading = false,
    this.seats = const [],
    this.selectedSeats = const [],
    this.isBooking = false,
    this.bookingId,
    this.basePrice = 0,
    this.error,
  });

  SelectSeatState copyWith({
    bool? isLoading,
    List<SeatEntity>? seats,
    List<String>? selectedSeats,
    bool? isBooking,
    String? bookingId,
    double? basePrice,
    String? error,
  }) {
    return SelectSeatState(
      isLoading: isLoading ?? this.isLoading,
      seats: seats ?? this.seats,
      selectedSeats: selectedSeats ?? this.selectedSeats,
      isBooking: isBooking ?? this.isBooking,
      bookingId: bookingId ?? this.bookingId,
      basePrice: basePrice ?? this.basePrice,
      error: error,
    );
  }
}
