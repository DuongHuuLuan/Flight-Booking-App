import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/repositories/service_repository.dart';

class AssignServicesUsecase {
  final ServiceRepository repository;
  AssignServicesUsecase(this.repository);

  Future<Either<Exception, void>> call({
    required String bookingId,
    required List<PassengerServiceInput> passengerServices,
  }) {
    return repository.assignServices(
      bookingId: bookingId,
      passengerServices: passengerServices,
    );
  }
}
