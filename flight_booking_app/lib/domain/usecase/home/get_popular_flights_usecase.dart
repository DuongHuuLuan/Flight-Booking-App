import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/entities/flight.dart';
import 'package:flight_booking_app/domain/repositories/home_repository.dart';

class GetPopularFlightsUsecase {
  final HomeRepository _homeRepository;

  GetPopularFlightsUsecase(this._homeRepository);

  Future<Either<Exception, List<FlightEntity>>> call() async {
    return await _homeRepository.getPopularFlights();
  }
}
