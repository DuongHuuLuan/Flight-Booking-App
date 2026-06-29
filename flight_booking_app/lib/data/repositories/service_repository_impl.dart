import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/data/datasources/remote/service_remote_data_source.dart';
import 'package:flight_booking_app/domain/entities/eligible_service_group.dart';
import 'package:flight_booking_app/domain/enums/age_group.dart';
import 'package:flight_booking_app/domain/repositories/service_repository.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  final ServiceRemoteDataSource _dataSource;

  ServiceRepositoryImpl(this._dataSource);

  @override
  Future<Either<Exception, EligibleServiceGroup>> getEligibleServices({
    required String zoneId,
    required AgeGroup ageGroup,
  }) async {
    try {
      final result = await _dataSource.getEligibleServices(
        zoneId: zoneId,
        ageGroup: ageGroup,
      );
      return Right(result);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, void>> assignServices({
    required String bookingId,
    required List<PassengerServiceInput> passengerServices,
  }) async {
    try {
      final payload = passengerServices
          .map(
            (ps) => {
              'passenger_id': ps.passengerId,
              'seat_label': ps.seatLabel,
              'service_ids': ps.serviceIds,
            },
          )
          .toList();
      await _dataSource.assignServices(
        bookingId: bookingId,
        passengerServices: payload,
      );
      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
