import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/entities/flight.dart';
import 'package:flight_booking_app/domain/repositories/home_repository.dart';

class GetAllFlightsUsecase {
  final HomeRepository _homeRepository;

  GetAllFlightsUsecase(this._homeRepository);

  Future<Either<Exception, List<FlightEntity>>> call() async {
    return await _homeRepository.getAllFlights();
  }
}
