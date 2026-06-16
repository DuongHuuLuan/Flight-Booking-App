import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/entities/flight.dart';
import 'package:flight_booking_app/domain/entities/flight_search_params.dart';

abstract class HomeRepository {
  Future<Either<Exception, List<FlightEntity>>> getPopularFlights();

  Future<Either<Exception, List<FlightEntity>>> searchFlights(
    FlightSearchParams params,
  );

  Future<Either<Exception, List<FlightEntity>>> getAllFlights();
}
