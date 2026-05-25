import 'package:flight_booking_app/data/models/airline_model.dart';
import 'package:flight_booking_app/data/models/airport_model.dart';
import 'package:flight_booking_app/domain/enums/cabin_class.dart';
import 'package:json_annotation/json_annotation.dart';

part 'flight_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FlightModel {
  final String id;
  final AirlineModel airline;
  final String flightNumber;
  final AirportModel departureAirport;
  final AirportModel arrivalAirport;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final int duration;
  final double price;
  final int stops;
  final CabinClass cabinClass;

  FlightModel({
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

  factory FlightModel.fromJson(Map<String, dynamic> json) =>
      _$FlightModelFromJson(json);
  Map<String, dynamic> toJson() => _$FlightModelToJson(this);
}
