import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/entities/passenger_entity.dart';
import 'package:flight_booking_app/domain/repositories/passenger_repository.dart';

class UpdatePassengerUsecase {
  final AbstractPassengerRepository repository;
  UpdatePassengerUsecase(this.repository);

  Future<Either<Exception, PassengerEntity>> call({
    required String bookingId,
    required String passengerId,
    required Map<String, dynamic> data,
  }) {
    return repository.updatePassenger(
      bookingId: bookingId,
      passengerId: passengerId,
      data: data,
    );
  }
}
