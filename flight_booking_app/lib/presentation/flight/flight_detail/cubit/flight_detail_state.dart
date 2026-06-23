import 'package:flight_booking_app/domain/entities/flight_detail_entity.dart';

class FlightDetailState {
  final bool isLoading;
  final FlightDetailEntity? flightDetail;
  final CabinClassOption? selectedCabinClass;
  final bool isBooking;

  FlightDetailState({
    this.isLoading = false,
    this.flightDetail,
    this.selectedCabinClass,
    this.isBooking = false,
  });

  FlightDetailState copyWith({
    bool? isLoading,
    FlightDetailEntity? flightDetail,
    CabinClassOption? selectedCabinClass,
    bool? isBooking,
  }) {
    return FlightDetailState(
      isLoading: isLoading ?? this.isLoading,
      flightDetail: flightDetail ?? this.flightDetail,
      selectedCabinClass: selectedCabinClass ?? this.selectedCabinClass,
      isBooking: isBooking ?? this.isBooking,
    );
  }
}
