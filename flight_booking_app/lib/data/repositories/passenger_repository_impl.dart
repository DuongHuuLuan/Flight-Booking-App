import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/data/datasources/remote/passenger_remote_data_source.dart';
import 'package:flight_booking_app/data/mappers/passenger/passenger_mapper.dart';
import 'package:flight_booking_app/data/models/passenger/create_passengers_request_model.dart';
import 'package:flight_booking_app/domain/entities/passenger_entity.dart';
import 'package:flight_booking_app/domain/repositories/passenger_repository.dart';

class PassengerRepositoryImpl implements AbstractPassengerRepository {
  final PassengerRemoteDataSource datasource;

  const PassengerRepositoryImpl(this.datasource);

  @override
  Future<List<PassengerEntity>> createPassengers({
    required String bookingId,
    required List<PassengerEntity> passengers,
  }) async {
    final request = CreatePassengersRequestModel(
      passengers: passengers.map(PassengerMapper.toCreateModel).toList(),
    );
    final models = await datasource.createPassengers(bookingId, request);
    return models.map((m) => PassengerMapper.toEntity(m)).toList();
  }

  @override
  Future<Either<Exception, PassengerEntity>> updatePassenger({
    required String bookingId,
    required String passengerId,
    required Map<String, dynamic> data,
  }) async {
    try {
      final model = await datasource.updatePassenger(
        bookingId: bookingId,
        passengerId: passengerId,
        data: data,
      );
      return Right(PassengerMapper.toEntity(model));
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
