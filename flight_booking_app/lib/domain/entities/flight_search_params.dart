import 'package:flight_booking_app/domain/enums/cabin_class.dart';
import 'package:flight_booking_app/domain/enums/trip_type.dart';

class FlightSearchParams {
  final TripType tripType;
  final String origin;
  final String destination;
  final DateTime departureDate;
  final DateTime? returnDate;
  final int passengerCount;
  final CabinClass cabinClass;

  FlightSearchParams({
    required this.tripType,
    required this.origin,
    required this.destination,
    required this.departureDate,
    this.returnDate,
    required this.passengerCount,
    required this.cabinClass,
  });

  FlightSearchParams copyWith({
    TripType? tripType,
    String? origin,
    String? destination,
    DateTime? departureDate,
    DateTime? returnDate,
    int? passengerCount,
    CabinClass? cabinClass,
  }) {
    return FlightSearchParams(
      tripType: tripType ?? this.tripType,
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      departureDate: departureDate ?? this.departureDate,
      returnDate: returnDate ?? this.returnDate,
      passengerCount: passengerCount ?? this.passengerCount,
      cabinClass: cabinClass ?? this.cabinClass,
    );
  }
}
