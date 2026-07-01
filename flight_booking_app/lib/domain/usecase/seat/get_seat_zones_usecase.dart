import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/entities/seat/seat_zone_entity.dart';
import 'package:flight_booking_app/domain/repositories/seat_repository.dart';

class GetSeatZonesUsecase {
  final SeatRepository repository;

  GetSeatZonesUsecase(this.repository);

  Future<Either<Exception, List<SeatZoneEntity>>> call(String flightId){
    return repository.getSeatZones(flightId);
  }
}
