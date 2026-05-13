import 'package:dartz/dartz.dart';

abstract class LocationRepository {
  Future<Either<Exception, List<String>>> getCountries();
  Future<Either<Exception, List<String>>> getCitiesForCountry(String country);
}
