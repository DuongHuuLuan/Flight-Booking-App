import 'package:flight_booking_app/domain/entities/airline.dart';
import 'package:flight_booking_app/domain/entities/airport.dart';

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

  String get stopsDisplay =>
      stops == 0 ? "Non Stop" : "$stops Stop${stops > 1 ? 's' : ''}";

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
    );
  }
}
