import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/entities/booking/booking_detail_entity.dart';
import 'package:flight_booking_app/domain/entities/booking/booking_entity.dart';
import 'package:flight_booking_app/domain/entities/seat/seat_input.dart';

abstract class BookingRepository {
  Future<Either<Exception, BookingEntity>> createBooking({
    required String flightId,
    required List<SeatInput> seats,
  });
  Future<Either<Exception, BookingEntity>> getBooking(String id);
  Future<Either<Exception, BookingDetailEntity>> getBookingDetail(String id);
  Future<Either<Exception, Map<String, dynamic>>> getPriceBreakdown(
    String bookingId,
  );
  Future<Either<Exception, Map<String, dynamic>>> mockPayment(String bookingId);
}
