import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/repositories/seat_repository.dart';

class SelectSeatUsecase {
  final SeatRepository repository;

  SelectSeatUsecase(this.repository);

  Future<Either<Exception, void>> call({
    required String bookingId,
    required String seatLabel,
  }) {
    return repository.selectSeat(bookingId: bookingId, seatLabel: seatLabel);
  }
}
