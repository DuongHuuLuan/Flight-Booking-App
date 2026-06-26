import 'package:flight_booking_app/domain/entities/passenger_entity.dart';

abstract class AbstractPassengerRepository {
  Future<List<PassengerEntity>> createPassengers({
    required String bookingId,
    required List<PassengerEntity> passengers,
  });
}
