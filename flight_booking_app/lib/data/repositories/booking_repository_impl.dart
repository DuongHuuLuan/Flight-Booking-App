import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/data/datasources/remote/booking_remote_data_source.dart';
import 'package:flight_booking_app/domain/entities/booking_entity.dart';
import 'package:flight_booking_app/domain/repositories/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource _dataSource;

  BookingRepositoryImpl(this._dataSource);

  @override
  Future<Either<Exception, BookingEntity>> createBooking({
    required String flightId,
    required String cabinClass,
    required List<String> seatLabels,
  }) async {
    try {
      final result = await _dataSource.createBooking(
        flightId: flightId,
        cabinClass: cabinClass,
        seatLabels: seatLabels,
      );
      return Right(result);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, BookingEntity>> getBooking(String id) async {
    try {
      final result = await _dataSource.getBooking(id);
      return Right(result);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
