import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/repositories/location_repository.dart';

class GetCityUsecase {
  final LocationRepository _repository;

  GetCityUsecase(this._repository);

  Future<Either<Exception, List<String>>> call(String country) async {
    return await _repository.getCitiesForCountry(country);
  }
}
