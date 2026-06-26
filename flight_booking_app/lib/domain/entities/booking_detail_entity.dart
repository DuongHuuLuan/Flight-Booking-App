import 'package:flight_booking_app/domain/entities/airline.dart';
import 'package:flight_booking_app/domain/entities/airport.dart';
import 'package:flight_booking_app/domain/entities/passenger_entity.dart';

class BookingDetailFlightEntity {
  final String id;
  final AirlineEntity airline;
  final String flightNumber;
  final AirportEntity departureAirport;
  final AirportEntity arrivalAirport;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final int duration;
  final int stops;

  const BookingDetailFlightEntity({
    required this.id,
    required this.airline,
    required this.flightNumber,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.stops,
  });
}

class BookingDetailEntity {
  final String id;
  final String flightId;
  final String cabinClass;
  final double totalPrice;
  final String status;
  final String? selectedSeats;
  final DateTime createdAt;
  final BookingDetailFlightEntity flight;
  final List<PassengerEntity> passengers;

  const BookingDetailEntity({
    required this.id,
    required this.flightId,
    required this.cabinClass,
    required this.totalPrice,
    required this.status,
    this.selectedSeats,
    required this.createdAt,
    required this.flight,
    required this.passengers,
  });
}
