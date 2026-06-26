import 'package:flight_booking_app/data/models/seat_model.dart';
import 'package:flight_booking_app/domain/entities/seat_entity.dart';

class SeatMapper {
  static SeatEntity fromModel(SeatModel model) {
    return SeatEntity(
      seatLabel: model.seatLabel,
      cabinClass: model.cabinClass,
      rowNumber: model.rowNumber,
      position: model.position,
      status: model.status,
    );
  }
}
