import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/Entities/flight.dart';
import 'package:flight_booking_app/domain/Entities/flight_search_params.dart';
import 'package:flight_booking_app/domain/repositories/home_repository.dart';

class SearchFlightsUsecsase {
  final HomeRepository _homeRepository;

  SearchFlightsUsecsase(this._homeRepository);

  Future<Either<Exception, List<FlightEntity>>> call(
    FlightSearchParams params,
  ) async {
    return _homeRepository.searchFlights(params);
  }
}
