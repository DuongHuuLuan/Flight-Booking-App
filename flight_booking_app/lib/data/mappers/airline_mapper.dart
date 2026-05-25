import 'package:flight_booking_app/data/models/airline_model.dart';
import 'package:flight_booking_app/domain/Entities/airline.dart';

class AirlineMapper {
  static AirlineEntity fromModel(AirlineModel model) {
    return AirlineEntity(
      id: model.id,
      name: model.name,
      logoUrl: model.logoUrl,
    );
  }

  static AirlineModel toModel(AirlineEntity entity) {
    return AirlineModel(
      id: entity.id,
      name: entity.name,
      logoUrl: entity.logoUrl,
    );
  }
}
