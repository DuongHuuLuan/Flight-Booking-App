import 'package:flight_booking_app/data/mappers/airline_mapper.dart';
import 'package:flight_booking_app/data/mappers/airport_mapper.dart';
import 'package:flight_booking_app/data/mappers/passenger_mapper.dart';
import 'package:flight_booking_app/data/models/booking_detail_model.dart';
import 'package:flight_booking_app/domain/entities/booking_detail_entity.dart';

class BookingDetailMapper {
  static BookingDetailFlightEntity flightFromModel(BookingDetailFlightModel model) {
    return BookingDetailFlightEntity(
      id: model.id,
      airline: AirlineMapper.fromModel(model.airline),
      flightNumber: model.flightNumber,
      departureAirport: AirportMapper.fromModel(model.departureAirport),
      arrivalAirport: AirportMapper.fromModel(model.arrivalAirport),
      departureTime: model.departureTime,
      arrivalTime: model.arrivalTime,
      duration: model.duration,
      stops: model.stops,
    );
  }

  static BookingDetailEntity fromModel(BookingDetailModel model) {
    return BookingDetailEntity(
      id: model.id,
      flightId: model.flightId,
      cabinClass: model.cabinClass,
      totalPrice: model.totalPrice,
      status: model.status,
      selectedSeats: model.selectedSeats,
      createdAt: model.createdAt,
      flight: flightFromModel(model.flight),
      passengers: model.passengers
          .map((e) => PassengerMapper.toEntity(e))
          .toList(),
    );
  }
}
