import 'package:flight_booking_app/data/models/seat/seat_zone_model.dart';
import 'package:flight_booking_app/domain/entities/seat/seat_zone_entity.dart';

class SeatZoneMapper {
  static SeatZoneEntity fromModel(SeatZoneModel model) {
    return SeatZoneEntity(
      zoneId: model.zoneId,
      zoneName: model.zoneName,
      priceModifier: model.priceModifier,
      colorHex: model.colorHex,
      availableSeats: model.availableSeats,
      pricePerSeat: model.pricePerSeat,
    );
  }
}
