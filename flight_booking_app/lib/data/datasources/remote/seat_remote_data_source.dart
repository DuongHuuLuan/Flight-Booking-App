import 'package:flight_booking_app/data/mappers/seat/seat_mapper.dart';
import 'package:flight_booking_app/data/mappers/seat/seat_zone_mapper.dart';
import 'package:flight_booking_app/data/services/seat_service.dart';
import 'package:flight_booking_app/domain/entities/seat/seat_entity.dart';
import 'package:flight_booking_app/domain/entities/seat/seat_zone_entity.dart';

class SeatRemoteDataSource {
  final SeatService _seatService;

  SeatRemoteDataSource(this._seatService);

  Future<List<SeatEntity>> getSeatLayout(String flightId) async {
    try {
      final response = await _seatService.getSeatLayout(flightId);
      final models = response.data;
      return models.map(SeatMapper.fromModel).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<SeatZoneEntity>> getSeatZones(String flightId) async {
    // MỚI
    try {
      final response = await _seatService.getSeatZones(flightId);
      final models = response.data;
      return models.map(SeatZoneMapper.fromModel).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> selectSeat({
    required String bookingId,
    required String seatLabel,
  }) async {
    try {
      await _seatService.selectSeat(bookingId, {'seat_label': seatLabel});
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
