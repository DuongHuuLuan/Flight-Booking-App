// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlightModel _$FlightModelFromJson(Map<String, dynamic> json) => FlightModel(
  id: json['id'] as String,
  airline: AirlineModel.fromJson(json['airline'] as Map<String, dynamic>),
  flightNumber: json['flightNumber'] as String,
  departureAirport: AirportModel.fromJson(
    json['departureAirport'] as Map<String, dynamic>,
  ),
  arrivalAirport: AirportModel.fromJson(
    json['arrivalAirport'] as Map<String, dynamic>,
  ),
  departureTime: DateTime.parse(json['departureTime'] as String),
  arrivalTime: DateTime.parse(json['arrivalTime'] as String),
  duration: (json['duration'] as num).toInt(),
  price: (json['price'] as num).toDouble(),
  stops: (json['stops'] as num).toInt(),
  cabinClass: $enumDecode(_$CabinClassEnumMap, json['cabinClass']),
);

Map<String, dynamic> _$FlightModelToJson(FlightModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'airline': instance.airline.toJson(),
      'flightNumber': instance.flightNumber,
      'departureAirport': instance.departureAirport.toJson(),
      'arrivalAirport': instance.arrivalAirport.toJson(),
      'departureTime': instance.departureTime.toIso8601String(),
      'arrivalTime': instance.arrivalTime.toIso8601String(),
      'duration': instance.duration,
      'price': instance.price,
      'stops': instance.stops,
      'cabinClass': instance.cabinClass.toJson(),
    };

const _$CabinClassEnumMap = {
  CabinClass.economy: 'economy',
  CabinClass.business: 'business',
  CabinClass.first: 'first',
};
