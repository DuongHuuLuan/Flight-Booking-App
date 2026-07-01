import 'package:flight_booking_app/data/models/flight/airline_model.dart';
import 'package:flight_booking_app/data/models/flight/airport_model.dart';
import 'package:flight_booking_app/data/models/passenger/passenger_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking_detail_model.g.dart';

@JsonSerializable()
class BookingServiceModel {
  final String id;
  final String passengerId;
  final String seatLabel;
  final String serviceId;
  final String serviceName;
  final String serviceType;
  final double price;
  final int quantity;

  const BookingServiceModel({
    required this.id,
    required this.passengerId,
    required this.seatLabel,
    required this.serviceId,
    required this.serviceName,
    required this.serviceType,
    required this.price,
    required this.quantity,
  });

  factory BookingServiceModel.fromJson(Map<String, dynamic> json) =>
      _$BookingServiceModelFromJson(json);
}

@JsonSerializable()
class BookingDetailFlightModel {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'airline')
  final AirlineModel airline;
  @JsonKey(name: 'flightNumber')
  final String flightNumber;
  @JsonKey(name: 'departureAirport')
  final AirportModel departureAirport;
  @JsonKey(name: 'arrivalAirport')
  final AirportModel arrivalAirport;
  @JsonKey(name: 'departureTime')
  final DateTime departureTime;
  @JsonKey(name: 'arrivalTime')
  final DateTime arrivalTime;
  @JsonKey(name: 'duration')
  final int duration;
  @JsonKey(name: 'stops')
  final int stops;

  const BookingDetailFlightModel({
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

  factory BookingDetailFlightModel.fromJson(Map<String, dynamic> json) =>
      _$BookingDetailFlightModelFromJson(json);
}

@JsonSerializable()
class BookingDetailModel {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'flightId')
  final String flightId;
  @JsonKey(name: 'totalPrice')
  final double totalPrice;
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'selectedSeats')
  final String? selectedSeats;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  @JsonKey(name: 'flight')
  final BookingDetailFlightModel flight;
  @JsonKey(name: 'passengers')
  final List<PassengerModel> passengers;
  @JsonKey(name: 'zonePriceTotal')
  final double? zonePriceTotal;
  @JsonKey(name: 'serviceTotal')
  final double? serviceTotal;
  @JsonKey(name: 'baggageTotal')
  final double? baggageTotal;
  @JsonKey(name: 'services')
  final List<BookingServiceModel>? services;

  const BookingDetailModel({
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

  factory BookingDetailModel.fromJson(Map<String, dynamic> json) =>
      _$BookingDetailModelFromJson(json);
}
