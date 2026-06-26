import 'package:flight_booking_app/data/models/booking_model.dart';
import 'package:flight_booking_app/domain/entities/booking_entity.dart';

class BookingMapper {
  static BookingEntity fromModel(BookingModel model) {
    return BookingEntity(
      id: model.id,
      flightId: model.flightId,
      cabinClass: model.cabinClass,
      totalPrice: model.totalPrice,
      status: model.status,
      createdAt: model.createdAt,
    );
  }
}
