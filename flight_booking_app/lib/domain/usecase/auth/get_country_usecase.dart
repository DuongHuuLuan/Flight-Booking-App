import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/repositories/location_repository.dart';

class GetCountryUsecase {
  final LocationRepository _repository;

  GetCountryUsecase(this._repository);

  Future<Either<Exception, List<String>>> call() async {
    return await _repository.getCountries();
  }
}
