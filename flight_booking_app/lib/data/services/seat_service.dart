import 'package:dio/dio.dart';
import 'package:flight_booking_app/data/models/base_response.dart';
import 'package:flight_booking_app/data/models/seat/seat_model.dart';
import 'package:flight_booking_app/data/models/seat/seat_zone_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'seat_service.g.dart';

@injectable
@RestApi()
abstract class SeatService {
  @factoryMethod
  factory SeatService(Dio dio) = _SeatService;

  @GET("/flights/{flightId}/seats")
  Future<HttpResponse<List<SeatModel>>> getSeatLayout(
    @Path("flightId") String flightId,
  );
  @GET("/flights/{flightId}/zones")
  Future<HttpResponse<List<SeatZoneModel>>> getSeatZones(
    @Path("flightId") String flightId,
  );

  @PATCH("/flights/bookings/{bookingId}/seat")
  Future<HttpResponse<BaseResponse<dynamic>>> selectSeat(
    @Path("bookingId") String bookingId,
    @Body() Map<String, dynamic> body,
  );
}
