import 'package:dio/dio.dart';
import 'package:flight_booking_app/data/models/base_response.dart';
import 'package:flight_booking_app/data/models/booking_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'booking_service.g.dart';

@injectable
@RestApi()
abstract class BookingService {
  @factoryMethod
  factory BookingService(Dio dio) = _BookingService;

  @POST("/bookings")
  Future<HttpResponse<BaseResponse<BookingModel>>> createBooking(
    @Body() Map<String, dynamic> body,
  );
}
