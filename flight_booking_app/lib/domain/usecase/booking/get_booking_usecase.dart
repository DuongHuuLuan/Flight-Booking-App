import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/entities/booking_entity.dart';
import 'package:flight_booking_app/domain/repositories/booking_repository.dart';

class GetBookingUsecase {
  final BookingRepository repository;

  GetBookingUsecase(this.repository);

  Future<Either<Exception, BookingEntity>> call(String id) {
    return repository.getBooking(id);
  }
}
