import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/entities/booking/booking_entity.dart';
import 'package:flight_booking_app/domain/entities/seat/seat_input.dart';
import 'package:flight_booking_app/domain/repositories/booking_repository.dart';

class CreateBookingUsecase {
  final BookingRepository repository;
  CreateBookingUsecase(this.repository);

  Future<Either<Exception, BookingEntity>> call({
    required String flightId,
    required String cabinClass,
    required List<SeatInput> seats, // SỬA: List<String> → List<SeatInput>
  }) {
    return repository.createBooking(
      flightId: flightId,
      cabinClass: cabinClass,
      seats: seats, // SỬA
    );
  }
}
