import 'package:flight_booking_app/data/mappers/airline_mapper.dart';
import 'package:flight_booking_app/data/mappers/airport_mapper.dart';
import 'package:flight_booking_app/data/mappers/passenger/passenger_mapper.dart';
import 'package:flight_booking_app/data/models/booking/booking_detail_model.dart';
import 'package:flight_booking_app/domain/entities/booking/booking_detail_entity.dart';

class BookingDetailMapper {
  static BookingDetailFlightEntity flightFromModel(
    BookingDetailFlightModel model,
  ) {
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

  static BookingServiceEntity serviceFromModel(BookingServiceModel model) {
    return BookingServiceEntity(
      id: model.id,
      passengerId: model.passengerId,
      seatLabel: model.seatLabel,
      serviceId: model.serviceId,
      serviceName: model.serviceName,
      serviceType: model.serviceType,
      price: model.price,
      quantity: model.quantity,
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
      zonePriceTotal: model.zonePriceTotal,
      serviceTotal: model.serviceTotal,
      baggageTotal: model.baggageTotal,
      services: model.services?.map((e) => serviceFromModel(e)).toList(),
    );
  }
}
