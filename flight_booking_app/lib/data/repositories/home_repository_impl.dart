import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/data/datasources/remote/home_remote_data_source.dart';
import 'package:flight_booking_app/domain/entities/flight.dart';
import 'package:flight_booking_app/domain/entities/flight_search_params.dart';
import 'package:flight_booking_app/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _homeRemoteDataSource;

  HomeRepositoryImpl(this._homeRemoteDataSource);
  @override
  Future<Either<Exception, List<FlightEntity>>> getPopularFlights() async {
    try {
      final flightEnity = await _homeRemoteDataSource.getPopularFlights();
      return Right(flightEnity);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, List<FlightEntity>>> searchFlights(
    FlightSearchParams params,
  ) async {
    try {
      final result = await _homeRemoteDataSource.searchFlights(params);
      return Right(result);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, List<FlightEntity>>> getAllFlights() async {
    try {
      final result = await _homeRemoteDataSource.getAllFlights();
      return Right(result);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
