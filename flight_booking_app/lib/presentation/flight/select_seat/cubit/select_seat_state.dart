import 'package:flight_booking_app/domain/entities/seat/seat_entity.dart';
import 'package:flight_booking_app/domain/entities/seat/seat_input.dart';
import 'package:flight_booking_app/domain/entities/seat/seat_zone_entity.dart';

class SelectSeatState {
  final bool isLoading;
  final List<SeatEntity> seats;
  final List<SeatInput> selectedSeats;
  final List<SeatZoneEntity> zones;
  final String? selectedZoneId;
  final bool isBooking;
  final String? bookingId;
  final double basePrice;
  final String? error;

  double get totalPrice {
    double total = 0;
    for (final seat in selectedSeats) {
      final zone = zones.cast<SeatZoneEntity?>().firstWhere(
        (z) => z?.zoneId == seat.zoneId,
        orElse: () => null,
      );
      total += basePrice * (zone?.priceModifier ?? 1.0);
    }
    return total;
  }

  SelectSeatState({
    this.isLoading = false,
    this.seats = const [],
    this.selectedSeats = const [],
    this.zones = const [],
    this.selectedZoneId,
    this.isBooking = false,
    this.bookingId,
    this.basePrice = 0,
    this.error,
  });

  SelectSeatState copyWith({
    bool? isLoading,
    List<SeatEntity>? seats,
    List<SeatInput>? selectedSeats,
    List<SeatZoneEntity>? zones,
    String? selectedZoneId,
    bool? isBooking,
    String? bookingId,
    double? basePrice,
    String? error,
  }) {
    return SelectSeatState(
      isLoading: isLoading ?? this.isLoading,
      seats: seats ?? this.seats,
      selectedSeats: selectedSeats ?? this.selectedSeats,
      zones: zones ?? this.zones,
      selectedZoneId: selectedZoneId ?? this.selectedZoneId,
      isBooking: isBooking ?? this.isBooking,
      bookingId: bookingId ?? this.bookingId,
      basePrice: basePrice ?? this.basePrice,
      error: error,
    );
  }
}
