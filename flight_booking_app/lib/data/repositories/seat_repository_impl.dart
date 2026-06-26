import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/data/datasources/remote/seat_remote_data_source.dart';
import 'package:flight_booking_app/domain/entities/seat_entity.dart';
import 'package:flight_booking_app/domain/repositories/seat_repository.dart';

class SeatRepositoryImpl implements SeatRepository {
  final SeatRemoteDataSource _dataSource;

  SeatRepositoryImpl(this._dataSource);

  @override
  Future<Either<Exception, List<SeatEntity>>> getSeatLayout(
    String flightId,
  ) async {
    try {
      final result = await _dataSource.getSeatLayout(flightId);
      return Right(result);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, void>> selectSeat({
    required String bookingId,
    required String seatLabel,
  }) async {
    try {
      await _dataSource.selectSeat(bookingId: bookingId, seatLabel: seatLabel);
      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
