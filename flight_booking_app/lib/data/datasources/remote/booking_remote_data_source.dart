import 'package:flight_booking_app/data/mappers/booking/booking_mapper.dart';
import 'package:flight_booking_app/data/models/booking/booking_detail_model.dart';
import 'package:flight_booking_app/data/models/booking/create_booking_request_model.dart';
import 'package:flight_booking_app/data/services/booking_service.dart';
import 'package:flight_booking_app/domain/entities/booking/booking_entity.dart';
import 'package:flight_booking_app/domain/entities/seat/seat_input.dart';

class BookingRemoteDataSource {
  final BookingService _bookingService;

  BookingRemoteDataSource(this._bookingService);

  Future<BookingEntity> createBooking({
    required String flightId,
    required List<SeatInput> seats,
  }) async {
    try {
      final request = CreateBookingRequestModel(
        flightId: flightId,
        seats: seats
            .map(
              (s) => SeatInputModel(seatLabel: s.seatLabel, zoneId: s.zoneId),
            )
            .toList(),
      );
      final response = await _bookingService.createBooking(request.toJson());
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

  Future<BookingDetailModel> getBookingDetail(String id) async {
    try {
      final response = await _bookingService.getBookingDetail(id);
      return response.data.data!;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getPriceBreakdown(String bookingId) async {
    try {
      final response = await _bookingService.getPriceBreakdown(bookingId);
      return response.data.data!;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> mockPayment(String bookingId) async {
    try {
      final response = await _bookingService.mockPayment(bookingId, {
        'payment_method': 'credit_card',
      });
      return response.data.data!;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
