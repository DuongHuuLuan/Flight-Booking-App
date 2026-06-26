import 'package:flight_booking_app/data/mappers/booking/booking_mapper.dart';
import 'package:flight_booking_app/data/services/booking_service.dart';
import 'package:flight_booking_app/domain/entities/booking_entity.dart';

class BookingRemoteDataSource {
  final BookingService _bookingService;

  BookingRemoteDataSource(this._bookingService);

  Future<BookingEntity> createBooking({
    required String flightId,
    required String cabinClass,
    required List<String> seatLabels,
  }) async {
    try {
      final body = <String, dynamic>{
        'flight_id': flightId,
        'cabin_class': cabinClass,
        'seat_labels': seatLabels,
      };
      final response = await _bookingService.createBooking(body);
      final model = response.data.data!;
      return BookingMapper.fromModel(model);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<BookingEntity> getBooking(String id) async {
    try {
      final response = await _bookingService.getBooking(id);
      final model = response.data.data!;
      return BookingMapper.fromModel(model);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
