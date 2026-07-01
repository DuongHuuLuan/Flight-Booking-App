import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/entities/eligible_service_group.dart';
import 'package:flight_booking_app/domain/enums/age_group.dart';
import 'package:flight_booking_app/domain/repositories/service_repository.dart';

class GetEligibleServicesUsecase {
  final ServiceRepository repository;
  GetEligibleServicesUsecase(this.repository);

  Future<Either<Exception, EligibleServiceGroup>> call({
    required String flightId,
    required String zoneId,
    required AgeGroup ageGroup,
  }) {
    return repository.getEligibleServices(
      flightId: flightId,
      zoneId: zoneId,
      ageGroup: ageGroup,
    );
  }
}
