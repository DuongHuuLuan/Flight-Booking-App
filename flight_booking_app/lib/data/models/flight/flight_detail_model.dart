import 'package:flight_booking_app/data/models/flight/airline_model.dart';
import 'package:flight_booking_app/data/models/flight/airport_model.dart';
import 'package:flight_booking_app/domain/enums/cabin_class.dart';
import 'package:json_annotation/json_annotation.dart';

part 'flight_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FlightDetailModel {
  final String id;
  final AirlineModel airline;
  final String flightNumber;
  final AirportModel departureAirport;
  final AirportModel arrivalAirport;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final int duration;
  final int stops;
  @JsonKey(name: 'cabinClasses')
  final List<CabinClassOptionModel> cabinClass;

  FlightDetailModel({
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

  factory FlightDetailModel.fromJson(Map<String, dynamic> json) =>
      _$FlightDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$FlightDetailModelToJson(this);
}

@JsonSerializable()
class CabinClassOptionModel {
  final CabinClass cabinClass;
  final double price;
  final List<String> amenities;

  CabinClassOptionModel({
    required this.cabinClass,
    required this.price,
    required this.amenities,
  });

  factory CabinClassOptionModel.fromJson(Map<String, dynamic> json) =>
      _$CabinClassOptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$CabinClassOptionModelToJson(this);
}
