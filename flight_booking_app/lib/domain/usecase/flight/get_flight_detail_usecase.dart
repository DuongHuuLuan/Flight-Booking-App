import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/entities/flight_detail_entity.dart';
import 'package:flight_booking_app/domain/repositories/flight_repository.dart';

class GetFlightDetailUsecase {
  final FlightRepository repository;

  GetFlightDetailUsecase(this.repository);

  Future<Either<Exception, FlightDetailEntity>> call(String id) {
    return repository.getFlightDetail(id);
  }
}
