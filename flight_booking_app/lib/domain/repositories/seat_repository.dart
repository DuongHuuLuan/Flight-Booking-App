import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/entities/seat/seat_entity.dart';
import 'package:flight_booking_app/domain/entities/seat/seat_zone_entity.dart';

abstract class SeatRepository {
  Future<Either<Exception, List<SeatEntity>>> getSeatLayout(String flightId);
  Future<Either<Exception, void>> selectSeat({
    required String bookingId,
    required String seatLabel,
  });
  Future<Either<Exception, List<SeatZoneEntity>>> getSeatZones(String flightId);
}
