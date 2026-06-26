import 'package:flight_booking_app/domain/entities/airline.dart';
import 'package:flight_booking_app/domain/entities/airport.dart';
import 'package:flight_booking_app/domain/enums/cabin_class.dart';

class FlightDetailEntity {
  final String id;
  final AirlineEntity airline;
  final String flightNumber;
  final AirportEntity departureAirport;
  final AirportEntity arrivalAirport;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final int duration;
  final int stops;
  final List<CabinClassOption> cabinClass;

  FlightDetailEntity({
    required this.id,
    required this.airline,
    required this.flightNumber,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.departureTime,
    required this.arrivalTime,
    required this.stops,
    required this.duration,
    required this.cabinClass,
  });
}

class CabinClassOption {
  final CabinClass cabinClass;
  final double price;
  final List<String> amenities;

  CabinClassOption({
    required this.cabinClass,
    required this.price,
    required this.amenities,
  });
}
