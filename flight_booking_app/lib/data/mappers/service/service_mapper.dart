import 'package:flight_booking_app/data/models/service/service_model.dart';
import 'package:flight_booking_app/domain/entities/seat/service_entity.dart';

class ServiceMapper {
  static ServiceEntity fromModel(ServiceModel model) {
    return ServiceEntity(
      serviceId: model.serviceId,
      type: model.type,
      name: model.name,
      price: model.price,
      maxPerPassenger: model.maxPerPassenger,
    );
  }
}
