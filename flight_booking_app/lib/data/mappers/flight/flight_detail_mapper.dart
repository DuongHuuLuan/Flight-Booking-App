import 'package:flight_booking_app/data/mappers/airline_mapper.dart';
import 'package:flight_booking_app/data/mappers/airport_mapper.dart';
import 'package:flight_booking_app/data/models/flight/flight_detail_model.dart';
import 'package:flight_booking_app/domain/entities/flight_detail_entity.dart';

class FlightDetailMapper {
  static FlightDetailEntity fromModel(FlightDetailModel model) {
    return FlightDetailEntity(
      id: model.id,
      airline: AirlineMapper.fromModel(model.airline),
      flightNumber: model.flightNumber,
      departureAirport: AirportMapper.fromModel(model.departureAirport),
      arrivalAirport: AirportMapper.fromModel(model.arrivalAirport),
      departureTime: model.departureTime,
      arrivalTime: model.arrivalTime,
      stops: model.stops,
      duration: model.duration,
      basePrice: model.basePrice,
    );
  }
}
