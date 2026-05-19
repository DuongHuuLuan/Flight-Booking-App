import 'package:flight_booking_app/domain/Entities/airline.dart';
import 'package:flight_booking_app/domain/Entities/airport.dart';
import 'package:flight_booking_app/domain/enums/cabin_class.dart';

class FlightEntity {
  final String id;
  final AirlineEntity airline;
  final String flightNumber;
  final AirportEntity departureAirport;
  final AirportEntity arrivalAirport;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final int duration;
  final double price;
  final int stops;
  final CabinClass cabinClass;

  FlightEntity({
    required this.id,
    required this.airline,
    required this.flightNumber,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.price,
    required this.stops,
    required this.cabinClass,
  });

  FlightEntity copyWith({
    String? id,
    AirlineEntity? airline,
    String? flightNumber,
    AirportEntity? departureAirport,
    AirportEntity? arrivalAirport,
    DateTime? departureTime,
    DateTime? arrivalTime,
    int? duration,
    double? price,
    int? stops,
    CabinClass? cabinClass,
  }) {
    return FlightEntity(
      id: id ?? this.id,
      airline: airline ?? this.airline,
      flightNumber: flightNumber ?? this.flightNumber,
      departureAirport: departureAirport ?? this.departureAirport,
      arrivalAirport: arrivalAirport ?? this.arrivalAirport,
      departureTime: departureTime ?? this.departureTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      duration: duration ?? this.duration,
      price: price ?? this.price,
      stops: stops ?? this.stops,
      cabinClass: cabinClass ?? this.cabinClass,
    );
  }
}
