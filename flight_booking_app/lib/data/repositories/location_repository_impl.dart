import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/data/datasources/remote/location_remote_data_source.dart';
import 'package:flight_booking_app/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource _remoteDataSource;

  LocationRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Exception, List<String>>> getCountries() async {
    try {
      final countries = await _remoteDataSource.getCountries();
      return Right(countries);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, List<String>>> getCitiesForCountry(
    String country,
  ) async {
    try {
      final cities = await _remoteDataSource.getCitiesForCountry(country);
      return Right(cities);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
