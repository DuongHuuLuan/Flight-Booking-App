import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/repositories/booking_repository.dart';

class GetPriceBreakdownUsecase {
  final BookingRepository repository;
  GetPriceBreakdownUsecase(this.repository);

  Future<Either<Exception, Map<String, dynamic>>> call(String bookingId) {
    return repository.getPriceBreakdown(bookingId);
  }
}
