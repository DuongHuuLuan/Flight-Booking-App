import 'package:flight_booking_app/data/mappers/airline_mapper.dart';
import 'package:flight_booking_app/data/mappers/airport_mapper.dart';
import 'package:flight_booking_app/data/models/flight/flight_model.dart';
import 'package:flight_booking_app/domain/entities/flight.dart';

class FlightMapper {
  static FlightEntity fromModel(FlightModel model) {
    return FlightEntity(
      id: model.id,
      airline: AirlineMapper.fromModel(model.airline),
      flightNumber: model.flightNumber,
      departureAirport: AirportMapper.fromModel(model.departureAirport),
      arrivalAirport: AirportMapper.fromModel(model.arrivalAirport),
      departureTime: model.departureTime,
      arrivalTime: model.arrivalTime,
      duration: model.duration,
      price: model.price,
      stops: model.stops,
    );
  }

  static FlightModel toModel(FlightEntity entity) {
    return FlightModel(
      id: entity.id,
      airline: AirlineMapper.toModel(entity.airline),
      flightNumber: entity.flightNumber,
      departureAirport: AirportMapper.toModel(entity.departureAirport),
      arrivalAirport: AirportMapper.toModel(entity.arrivalAirport),
      departureTime: entity.departureTime,
      arrivalTime: entity.arrivalTime,
      duration: entity.duration,
      price: entity.price,
      stops: entity.stops,
    );
  }
}
