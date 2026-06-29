import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/repositories/booking_repository.dart';

class MockPaymentUsecase {
  final BookingRepository repository;
  MockPaymentUsecase(this.repository);

  Future<Either<Exception, Map<String, dynamic>>> call(String bookingId) {
    return repository.mockPayment(bookingId);
  }
}
