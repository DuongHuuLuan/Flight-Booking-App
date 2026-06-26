import 'package:flight_booking_app/domain/entities/flight_detail_entity.dart';

class FlightDetailState {
  final bool isLoading;
  final FlightDetailEntity? flightDetail;
  final CabinClassOption? selectedCabinClass;
  final bool isBooking;
  final String? bookingId;

  FlightDetailState({
    this.isLoading = false,
    this.flightDetail,
    this.selectedCabinClass,
    this.isBooking = false,
    this.bookingId,
  });

  FlightDetailState copyWith({
    bool? isLoading,
    FlightDetailEntity? flightDetail,
    CabinClassOption? selectedCabinClass,
    bool? isBooking,
    String? bookingId,
  }) {
    return FlightDetailState(
      isLoading: isLoading ?? this.isLoading,
      flightDetail: flightDetail ?? this.flightDetail,
      selectedCabinClass: selectedCabinClass ?? this.selectedCabinClass,
      isBooking: isBooking ?? this.isBooking,
      bookingId: bookingId ?? this.bookingId,
    );
  }
}
