import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/data/datasources/remote/flight_remote_data_source.dart';
import 'package:flight_booking_app/domain/entities/flight_detail_entity.dart';
import 'package:flight_booking_app/domain/repositories/flight_repository.dart';

class FlightRepositoryImpl implements FlightRepository {
  final FlightRemoteDataSource remoteDataSource;

  FlightRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Exception, FlightDetailEntity>> getFlightDetail(
    String id,
  ) async {
    try {
      final result = await remoteDataSource.getFlightDetail(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
