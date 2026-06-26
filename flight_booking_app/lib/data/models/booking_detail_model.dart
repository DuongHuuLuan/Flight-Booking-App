import 'package:json_annotation/json_annotation.dart';
import 'package:flight_booking_app/data/models/airline_model.dart';
import 'package:flight_booking_app/data/models/airport_model.dart';
import 'package:flight_booking_app/data/models/passenger_model.dart';

part 'booking_detail_model.g.dart';

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

  @JsonKey(name: 'cabinClass')
  final String cabinClass;

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

  const BookingDetailModel({
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

  factory BookingDetailModel.fromJson(Map<String, dynamic> json) =>
      _$BookingDetailModelFromJson(json);
}
