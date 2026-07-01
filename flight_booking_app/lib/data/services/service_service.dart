import 'package:dio/dio.dart';
import 'package:flight_booking_app/data/models/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'service_service.g.dart';

@injectable
@RestApi()
abstract class ServiceService {
  @factoryMethod
  factory ServiceService(Dio dio) = _ServiceService;

  @GET("/services/eligible")
  Future<HttpResponse<BaseResponse<dynamic>>> getEligibleServices(
    @Query("flight_id") String flightId,
    @Query("zone_id") String zoneId,
    @Query("age_group") String ageGroup,
  );

  @POST("/bookings/{bookingId}/services")
  Future<HttpResponse<BaseResponse<dynamic>>> assignServices(
    @Path("bookingId") String bookingId,
    @Body() Map<String, dynamic> body,
  );
}
