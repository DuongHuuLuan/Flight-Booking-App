import 'package:dartz/dartz.dart';
import 'package:flight_booking_app/domain/entities/booking_detail_entity.dart';
import 'package:flight_booking_app/domain/repositories/booking_repository.dart';

class GetBookingDetailUsecase {
  final BookingRepository repository;

  GetBookingDetailUsecase(this.repository);

  Future<Either<Exception, BookingDetailEntity>> call(String id) {
    return repository.getBookingDetail(id);
  }
}
