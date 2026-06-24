import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/entities/seat_entity.dart';
import 'package:flight_booking_app/domain/repositories/seat_repository.dart';

class GetSeatLayoutUsecase {
  final SeatRepository repository;

  GetSeatLayoutUsecase(this.repository);

  Future<Either<Exception, List<SeatEntity>>> call(String flightId) {
    return repository.getSeatLayout(flightId);
  }
}
