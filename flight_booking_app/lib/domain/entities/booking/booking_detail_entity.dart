import 'package:equatable/equatable.dart';
import 'package:flight_booking_app/domain/entities/airline.dart';
import 'package:flight_booking_app/domain/entities/airport.dart';
import 'package:flight_booking_app/domain/entities/passenger_entity.dart';

class BookingDetailFlightEntity extends Equatable {
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

  @override
  List<Object?> get props => [
    id,
    airline,
    flightNumber,
    departureAirport,
    arrivalAirport,
    departureTime,
    arrivalTime,
    duration,
    stops,
  ];
}

class BookingServiceEntity extends Equatable {
  final String id;
  final String passengerId;
  final String seatLabel;
  final String serviceId;
  final String serviceName;
  final String serviceType;
  final double price;
  final int quantity;

  const BookingServiceEntity({
    required this.id,
    required this.passengerId,
    required this.seatLabel,
    required this.serviceId,
    required this.serviceName,
    required this.serviceType,
    required this.price,
    required this.quantity,
  });

  @override
  List<Object?> get props => [
    id,
    passengerId,
    seatLabel,
    serviceId,
    serviceName,
    serviceType,
    price,
    quantity,
  ];
}

class BookingDetailEntity extends Equatable {
  final String id;
  final String flightId;
  final double totalPrice;
  final String status;
  final String? selectedSeats;
  final DateTime createdAt;
  final BookingDetailFlightEntity flight;
  final List<PassengerEntity> passengers;
  final double? zonePriceTotal;
  final double? serviceTotal;
  final double? baggageTotal;
  final List<BookingServiceEntity>? services;

  const BookingDetailEntity({
    required this.id,
    required this.flightId,
    required this.totalPrice,
    required this.status,
    this.selectedSeats,
    required this.createdAt,
    required this.flight,
    required this.passengers,
    this.zonePriceTotal,
    this.serviceTotal,
    this.baggageTotal,
    this.services,
  });
  @override
  List<Object?> get props => [
    id,
    flightId,
    totalPrice,
    status,
    selectedSeats,
    createdAt,
    flight,
    passengers,
    zonePriceTotal,
    serviceTotal,
    baggageTotal,
    services,
  ];
}
