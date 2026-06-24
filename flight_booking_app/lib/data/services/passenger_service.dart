import 'package:dio/dio.dart';
import 'package:flight_booking_app/data/models/base_response.dart';
import 'package:flight_booking_app/data/models/create_passengers_request_model.dart';
import 'package:flight_booking_app/data/models/passenger_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'passenger_service.g.dart';

@injectable
@RestApi()
abstract class PassengerService {
  @factoryMethod
  factory PassengerService(Dio dio) = _PassengerService;

  @POST("/bookings/{bookingId}/passengers")
  Future<HttpResponse<BaseResponse<List<PassengerModel>>>> createPassengers(
    @Path("bookingId") String bookingId,
    @Body() CreatePassengersRequestModel body,
  );
}
