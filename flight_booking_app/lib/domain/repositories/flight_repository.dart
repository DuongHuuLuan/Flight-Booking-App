import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/entities/flight_detail_entity.dart';

abstract class FlightRepository {
  Future<Either<Exception, FlightDetailEntity>> getFlightDetail(String id);
}
