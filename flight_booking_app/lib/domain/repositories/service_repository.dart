import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/entities/eligible_service_group.dart';
import 'package:flight_booking_app/domain/enums/age_group.dart';

class PassengerServiceInput {
  final String passengerId;
  final String seatLabel;
  final List<String> serviceIds;
  const PassengerServiceInput({
    required this.passengerId,
    required this.seatLabel,
    required this.serviceIds,
  });
}

abstract class ServiceRepository {
  Future<Either<Exception, EligibleServiceGroup>> getEligibleServices({
    required String flightId,
    required String zoneId,
    required AgeGroup ageGroup,
  });
  Future<Either<Exception, void>> assignServices({
    required String bookingId,
    required List<PassengerServiceInput> passengerServices,
  });
}
