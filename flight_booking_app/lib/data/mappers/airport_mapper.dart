import 'package:flight_booking_app/data/models/airport_model.dart';
import 'package:flight_booking_app/domain/entities/airport.dart';

class AirportMapper {
  static AirportEntity fromModel(AirportModel model) {
    return AirportEntity(
      code: model.code,
      name: model.name,
      city: model.city,
      country: model.country,
    );
  }

  static AirportModel toModel(AirportEntity entity) {
    return AirportModel(
      code: entity.code,
      name: entity.name,
      city: entity.city,
      country: entity.country,
    );
  }
}
