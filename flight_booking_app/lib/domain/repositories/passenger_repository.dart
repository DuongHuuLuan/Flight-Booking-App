import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/entities/passenger_entity.dart';

abstract class AbstractPassengerRepository {
  Future<List<PassengerEntity>> createPassengers({
    required String bookingId,
    required List<PassengerEntity> passengers,
  });
  Future<Either<Exception, PassengerEntity>> updatePassenger({
    required String bookingId,
    required String passengerId,
    required Map<String, dynamic> data
});
}
