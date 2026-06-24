import 'package:flight_booking_app/domain/entities/passenger_entity.dart';
import 'package:flight_booking_app/domain/repositories/passenger_repository.dart';

class CreatePassengersUseCase {
  final AbstractPassengerRepository repository;

  const CreatePassengersUseCase(this.repository);

  Future<List<PassengerEntity>> execute({
    required String bookingId,
    required List<PassengerEntity> passengers,
  }) {
    return repository.createPassengers(
      bookingId: bookingId,
      passengers: passengers,
    );
  }
}
