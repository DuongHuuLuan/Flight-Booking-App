import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/entities/booking_entity.dart';

abstract class BookingRepository {
  Future<Either<Exception, BookingEntity>> createBooking({
    required String flightId,
    required String cabinClass,
    required List<String> seatLabels,
  });

  Future<Either<Exception, BookingEntity>> getBooking(String id);
}
